import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/auth/data/repos/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo;

  LoginCubit(this._authRepo) : super(LoginInitial());

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(LoginPasswordVisibilityChanged(_isPasswordVisible));
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await _authRepo.loginWithEmail(
      email: email.trim(),
      password: password,
    );
    result.fold(
      (error) => emit(LoginFailure(error)),
      (user) => emit(LoginSuccess(user)),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());
    final result = await _authRepo.signInWithGoogle();
    result.fold(
      (error) => emit(LoginFailure(error)),
      (user) => emit(LoginSuccess(user)),
    );
  }

  Future<void> resetPassword({required String email}) async {
    emit(ResetPasswordLoading());
    final result = await _authRepo.resetPassword(email: email.trim());
    result.fold(
      (error) => emit(ResetPasswordFailure(error)),
      (message) => emit(ResetPasswordSuccess(message)),
    );
  }
}
