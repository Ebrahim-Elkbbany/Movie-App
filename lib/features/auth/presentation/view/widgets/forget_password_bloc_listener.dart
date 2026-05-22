import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/widgets/feedback/custom_snack_bar.dart';
import 'package:movie_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';

class ForgetPasswordBlocListener extends StatelessWidget {
  const ForgetPasswordBlocListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (p, c) =>
          c is ResetPasswordLoading ||
          c is ResetPasswordSuccess ||
          c is ResetPasswordFailure,
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const PopScope(
              canPop: false,
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFFFFBB3B)),
              ),
            ),
          );
        } else if (state is ResetPasswordSuccess) {
          Navigator.pop(context); // Pop the loading dialog
          CustomSnackBar.show(
            context: context,
            message: state.message,
          );
          Navigator.pop(context); // Pop the ForgetPasswordView to return to Login
        } else if (state is ResetPasswordFailure) {
          Navigator.pop(context); // Pop the loading dialog
          CustomSnackBar.show(
            context: context,
            message: state.errorMessage,
            isError: true,
          );
        }
      },
      child: child,
    );
  }
}
