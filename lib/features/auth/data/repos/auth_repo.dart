import 'package:dartz/dartz.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<String, UserModel>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<String, UserModel>> signupWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatarPath,
  });

  Future<Either<String, UserModel>> signInWithGoogle();

  Future<Either<String, String>> resetPassword({required String email});

  Future<Either<String, void>> logout();
}
