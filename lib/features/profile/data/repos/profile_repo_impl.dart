import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/core/network/tocken_storage_service.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/profile/data/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  ProfileRepoImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, UserModel>> getUserData() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return left(ServerFailure('User not logged in'));
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists || doc.data() == null) {
        return left(ServerFailure('User data not found'));
      }

      final userModel = UserModel.fromJson(doc.data()!);
      return right(userModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUserData(UserModel userModel) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return left(ServerFailure('User not logged in'));
      }

      if (user.displayName != userModel.name) {
        await user.updateDisplayName(userModel.name);
      }

      await _firestore
          .collection('users')
          .doc(user.uid)
          .update(userModel.toJson());

      return right(userModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      await TokenStorageService().deleteToken();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final uid = user.uid;
        final docSnapshot = await _firestore.collection('users').doc(uid).get();
        final userData = docSnapshot.data();

        await _firestore.collection('users').doc(uid).delete();

        try {
          await user.delete();
          await TokenStorageService().deleteToken();
        } catch (authError) {
          if (userData != null) {
            await _firestore.collection('users').doc(uid).set(userData);
          }
          rethrow;
        }
      }
      return right(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return left(ServerFailure('Please login again before deleting your account.'));
      }
      return left(ServerFailure(e.message ?? 'Failed to delete account'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> getWatchlist() {
    final user = _firebaseAuth.currentUser;
    if (user == null) return const Stream.empty();

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('watchlist')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return data;
            }).toList());
  }

  @override
  Stream<List<Map<String, dynamic>>> getHistory() {
    final user = _firebaseAuth.currentUser;
    if (user == null) return const Stream.empty();

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('history')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return data;
            }).toList());
  }
}
