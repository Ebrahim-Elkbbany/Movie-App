import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/constants/assets_paths.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/auth/data/repos/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepo _authRepo;

  SignupCubit(this._authRepo) : super(SignupInitial());

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String _selectedAvatar = AssetsPaths.avatar1;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  String get selectedAvatar => _selectedAvatar;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(SignupPasswordVisibilityChanged(_isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    emit(SignupConfirmPasswordVisibilityChanged(_isConfirmPasswordVisible));
  }

  void selectAvatar(String avatarPath) {
    _selectedAvatar = avatarPath;
    emit(SignupAvatarChanged(avatarPath));
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(SignupLoading());
    final result = await _authRepo.signupWithEmail(
      name: name.trim(),
      email: email.trim(),
      password: password,
      phone: phone.trim(),
      avatarPath: _selectedAvatar,
    );
    result.fold(
      (error) => emit(SignupFailure(error)),
      (user) => emit(SignupSuccess(user)),
    );
  }

  Future<void> signupWithGoogle() async {
    emit(SignupLoading());
    final result = await _authRepo.signInWithGoogle();
    result.fold(
      (error) => emit(SignupFailure(error)),
      (user) => emit(SignupSuccess(user)),
    );
  }
}
