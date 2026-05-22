import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/login/domain/entites/login_request_entity.dart';
import 'package:movie_app/features/login/domain/entites/user_data_entity.dart';
import 'package:movie_app/features/login/domain/use_case/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginInitial());

  final LoginUseCase _loginUseCase;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final response = await _loginUseCase.call(
      param: LoginRequestEntity(
        email: email,
        password: password,
      ),
    );
    response.fold(
      (error) => emit(LoginFailure(errorMessage: error.errorMessage)),
      (userData) => emit(LoginSuccess(userDataEntity: userData)),
    );
  }
}
