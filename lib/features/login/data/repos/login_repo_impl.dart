import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/core/network/tocken_storage_service.dart';
import 'package:movie_app/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:movie_app/features/login/domain/entites/login_request_entity.dart';
import 'package:movie_app/features/login/domain/entites/user_data_entity.dart';
import 'package:movie_app/features/login/domain/repos/login_repo.dart';


class LoginRepoImpl extends LoginRepo {
  final LoginRemoteDataSource loginRemoteDataSource;


  LoginRepoImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, UserDataEntity>> login({
    required LoginRequestEntity loginRequestEntity,
  }) async {
    final result = await loginRemoteDataSource.login(
      loginRequestEntity: loginRequestEntity,
    );

    return result.fold(
      (failure) => Left(failure),
      (userData) async {
        await TokenStorageService().saveToken(userData.token);
        return Right(userData);
      },
    );
  }

}
