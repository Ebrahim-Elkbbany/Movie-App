import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/navigation/app_routes.dart';
import 'package:movie_app/core/widgets/feedback/custom_snack_bar.dart';
import 'package:movie_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading || state is ResetPasswordLoading) {
          _showLoading(context);
        } else {
          _hideLoading(context);
        }

        if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.mainView,
            (route) => false,
          );
        }

        if (state is LoginFailure) {
          CustomSnackBar.show(context: context, message: state.errorMessage, isError: true);
        }

        if (state is ResetPasswordSuccess) {
          CustomSnackBar.show(context: context, message: state.message);
          Navigator.pop(context);
        }

        if (state is ResetPasswordFailure) {
          CustomSnackBar.show(context: context, message: state.errorMessage, isError: true);
        }
      },
      child: child,
    );
  }

  void _showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: Color(0xFFFFBB3B)),
      ),
    );
  }

  void _hideLoading(BuildContext context) {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }
}
