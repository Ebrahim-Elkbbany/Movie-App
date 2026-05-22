import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipes/features/auth/data/models/user_model.dart';

abstract class SignupRepo{
  Future<Either<String,UserCredential>> signupWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
  });

  Future<Either<String,User>> signupWithGoogle();
  Future<void> uploadUserData({required UserModel userModel});

}