import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/features/login/domain/entites/login_request_entity.dart';
import 'package:movie_app/features/login/domain/entites/user_data_entity.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserDataEntity>> login({
    required LoginRequestEntity loginRequestEntity,
  });

}
