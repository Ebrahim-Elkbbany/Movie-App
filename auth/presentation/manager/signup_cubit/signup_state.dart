part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}
class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final User user;

  SignupSuccess(this.user);
}
class SignupFailure extends SignupState {
  final String error;
  SignupFailure(this.error);
}
class ChangePasswordVisibility extends SignupState {}
