part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel user;
  LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final String errorMessage;
  LoginFailure(this.errorMessage);
}

class LoginPasswordVisibilityChanged extends LoginState {
  final bool isVisible;
  LoginPasswordVisibilityChanged(this.isVisible);
}

class ResetPasswordLoading extends LoginState {}

class ResetPasswordSuccess extends LoginState {
  final String message;
  ResetPasswordSuccess(this.message);
}

class ResetPasswordFailure extends LoginState {
  final String errorMessage;
  ResetPasswordFailure(this.errorMessage);
}
