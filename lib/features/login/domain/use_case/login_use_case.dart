import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/core/use_case/use_case_with_param.dart';
import 'package:movie_app/features/login/domain/entites/login_request_entity.dart';
import 'package:movie_app/features/login/domain/entites/user_data_entity.dart';
import 'package:movie_app/features/login/domain/repos/login_repo.dart';

class LoginUseCase
    extends UseCaseWithParam<UserDataEntity, LoginRequestEntity> {
  final LoginRepo loginRepo;
  LoginUseCase({required this.loginRepo});

  @override
  Future<Either<Failure, UserDataEntity>> call({
    required LoginRequestEntity param,
  }) async {
    return await loginRepo.login(loginRequestEntity: param);
  }
}
