import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/auth/data/repos/auth_repo.dart';
import 'package:movie_app/features/profile/data/repos/profile_repo.dart';
import 'package:movie_app/features/profile/presentation/manager/edit_profile_cubit/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final ProfileRepo _profileRepo;
  final AuthRepo _authRepo;

  EditProfileCubit(this._profileRepo, this._authRepo) : super(EditProfileInitial());

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late String selectedAvatarPath;
  late UserModel _currentUser;

  void initData(UserModel user) {
    _currentUser = user;
    nameController = TextEditingController(text: user.name);
    phoneController = TextEditingController(text: user.phone);
    selectedAvatarPath = user.avatarPath;
  }

  void changeAvatar(String avatarPath) {
    selectedAvatarPath = avatarPath;
    emit(EditProfileAvatarChanged());
  }

  Future<void> updateUserData() async {
    emit(EditProfileUpdateLoading());
    final updatedUser = UserModel(
      userId: _currentUser.userId,
      name: nameController.text.trim(),
      email: _currentUser.email,
      phone: phoneController.text.trim(),
      avatarPath: selectedAvatarPath,
      createdAt: _currentUser.createdAt,
    );

    final result = await _profileRepo.updateUserData(updatedUser);
    result.fold(
      (failure) => emit(EditProfileUpdateError(message: failure.errorMessage)),
      (userModel) => emit(EditProfileUpdateSuccess()),
    );
  }

  Future<void> resetPassword() async {
    emit(EditProfileResetPasswordLoading());
    final result = await _authRepo.resetPassword(email: _currentUser.email);
    result.fold(
      (errorMessage) => emit(EditProfileResetPasswordError(message: errorMessage)),
      (successMessage) => emit(EditProfileResetPasswordSuccess(message: successMessage)),
    );
  }

  Future<void> deleteAccount() async {
    emit(EditProfileDeleteLoading());
    final result = await _profileRepo.deleteAccount();
    result.fold(
      (failure) => emit(EditProfileDeleteError(message: failure.errorMessage)),
      (_) => emit(EditProfileDeleteSuccess()),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
