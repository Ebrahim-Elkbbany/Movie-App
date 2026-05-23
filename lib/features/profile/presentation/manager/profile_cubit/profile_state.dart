import 'package:movie_app/features/auth/data/models/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class ProfileActionLoading extends ProfileState {}

class ProfileLogoutSuccess extends ProfileState {}

class ProfileDeleteSuccess extends ProfileState {}

class ProfileActionError extends ProfileState {
  final String message;
  ProfileActionError(this.message);
}
