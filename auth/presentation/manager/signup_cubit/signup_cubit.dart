import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/helpers/cache_helper.dart';
import 'package:food_recipes/features/auth/data/repos/signup_repo.dart';
import 'package:food_recipes/features/auth/presentation/views/email_verification_view.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.signupRepo) : super(SignupLoading());
  SignupRepo signupRepo;

  var formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  Future signupWithEmail(BuildContext context) async {
    emit(SignupLoading());
    var response = await signupRepo.signupWithEmail(
      email: email.text,
      password: password.text,
      name: name.text,
      phone: phone.text,
    );
    response.fold((error) {
      emit(SignupFailure(error));
    }, (userCredential) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmailVerificationScreen(email: email.text),
            ),
          );
        },
      );
      emit(SignupSuccess(userCredential.user!));
    });
  }

  Future signupWithGoogle(BuildContext context) async {
    emit(SignupLoading());
    var response = await signupRepo.signupWithGoogle();
    response.fold((error) {
      emit(SignupFailure(error));
    }, (userCredential) {
      CacheHelper.saveData(key: 'token', value: userCredential.uid);
      emit(SignupSuccess(userCredential));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibility());
  }

  @override
  Future<void> close() {
    phone.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    name.dispose();
    return super.close();
  }
}
