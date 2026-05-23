import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> getUserData();
  Future<Either<Failure, UserModel>> updateUserData(UserModel user);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> deleteAccount();
  Stream<List<Map<String, dynamic>>> getWatchlist();
  Stream<List<Map<String, dynamic>>> getHistory();
}
