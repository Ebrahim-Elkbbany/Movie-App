import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/core/network/api_end_points.dart';
import 'package:movie_app/core/network/api_service.dart';
import 'package:movie_app/features/login/data/models/login_models/login_request_model.dart';
import 'package:movie_app/features/login/data/models/login_models/login_response_model.dart';
import 'package:movie_app/features/login/domain/entites/login_request_entity.dart';
import 'package:movie_app/features/login/domain/entites/user_data_entity.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failure, UserDataEntity>> login({
    required LoginRequestEntity loginRequestEntity,
  }); 


}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiService apiService;

  LoginRemoteDataSourceImpl({required this.apiService});
  @override
  Future<Either<Failure, UserDataEntity>> login({
    required LoginRequestEntity loginRequestEntity,
  }) async {
    final response = await apiService.post(
      urlEndPoint: ApisEndpoints.login,
      data: LoginRequestModel(
        email: loginRequestEntity.email,
        password: loginRequestEntity.password,
      ).toJson(),
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(LoginResponseModel.fromJson(data)),
    );
  }

}
