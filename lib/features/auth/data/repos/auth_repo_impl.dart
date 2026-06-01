import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/auth/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepoImpl(this._auth, this._firestore);

  @override
  Future<Either<String, UserModel>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!(_auth.currentUser?.emailVerified ?? false)) {
        await _auth.currentUser?.sendEmailVerification();
        return const Left('Email not verified. Check your inbox.');
      }
      final doc = await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();
      return Right(UserModel.fromJson(doc.data()!));
    } on FirebaseAuthException catch (e) {
      return Left(_mapAuthError(e.code));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserModel>> signupWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatarPath,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(name);
      final user = UserModel(
        userId: credential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        avatarPath: avatarPath,
        createdAt: DateTime.now(),
      );
      await _firestore.collection('users').doc(user.userId).set(user.toJson());
      await credential.user?.sendEmailVerification();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(_mapAuthError(e.code));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserModel>> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize();
      final googleUser = await GoogleSignIn.instance.authenticate();
      GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      final uid = userCredential.user!.uid;
      final googleName = userCredential.user!.displayName?.isNotEmpty == true
          ? userCredential.user!.displayName!
          : 'Google User';
      final googleEmail = userCredential.user!.email?.isNotEmpty == true
          ? userCredential.user!.email!
          : 'No Email Provided';

      // Use default avatar1 instead of Google photo as requested
      const googlePhoto = AppImages.avatar1;

      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        final existingData = doc.data()!;
        final updatedUser = UserModel(
          userId: uid,
          name: googleName,
          email: googleEmail,
          phone: existingData['phone'] ?? '',
          avatarPath: googlePhoto,
          createdAt:
              (existingData['createdAt'] as Timestamp?)?.toDate() ??
              DateTime.now(),
        );
        await _firestore
            .collection('users')
            .doc(uid)
            .update(updatedUser.toJson());
        return Right(updatedUser);
      }
      final user = UserModel(
        userId: uid,
        name: googleName,
        email: googleEmail,
        phone: '',
        avatarPath: googlePhoto,
        createdAt: DateTime.now(),
      );
      await _firestore.collection('users').doc(uid).set(user.toJson());
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(_mapAuthError(e.code));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> resetPassword({required String email}) async {
    if (email.trim().isEmpty) {
      return const Left('Please enter your email first.');
    }
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return const Right('Password reset email sent. Check your inbox.');
    } on FirebaseAuthException catch (e) {
      return Left(_mapAuthError(e.code));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    try {
      await _auth.signOut();
      await GoogleSignIn.instance.signOut();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  String _mapAuthError(String code) {
    switch (code) {
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'Invalid email address format.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
