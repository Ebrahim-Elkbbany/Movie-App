part of 'signup_cubit.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final UserModel user;
  SignupSuccess(this.user);
}

class SignupFailure extends SignupState {
  final String errorMessage;
  SignupFailure(this.errorMessage);
}

class SignupPasswordVisibilityChanged extends SignupState {
  final bool isVisible;
  SignupPasswordVisibilityChanged(this.isVisible);
}

class SignupConfirmPasswordVisibilityChanged extends SignupState {
  final bool isVisible;
  SignupConfirmPasswordVisibilityChanged(this.isVisible);
}

class SignupAvatarChanged extends SignupState {
  final String avatarPath;
  SignupAvatarChanged(this.avatarPath);
}
