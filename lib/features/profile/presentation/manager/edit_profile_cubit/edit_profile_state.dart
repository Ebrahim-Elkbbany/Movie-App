abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileUpdateLoading extends EditProfileState {}
class EditProfileUpdateSuccess extends EditProfileState {}
class EditProfileUpdateError extends EditProfileState {
  final String message;
  EditProfileUpdateError({required this.message});
}

class EditProfileResetPasswordLoading extends EditProfileState {}
class EditProfileResetPasswordSuccess extends EditProfileState {
  final String message;
  EditProfileResetPasswordSuccess({required this.message});
}
class EditProfileResetPasswordError extends EditProfileState {
  final String message;
  EditProfileResetPasswordError({required this.message});
}

class EditProfileAvatarChanged extends EditProfileState {}

class EditProfileDeleteLoading extends EditProfileState {}
class EditProfileDeleteSuccess extends EditProfileState {}
class EditProfileDeleteError extends EditProfileState {
  final String message;
  EditProfileDeleteError({required this.message});
}
