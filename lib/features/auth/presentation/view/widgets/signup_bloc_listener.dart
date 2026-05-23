import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/navigation/app_routes.dart';
import 'package:movie_app/core/widgets/feedback/custom_snack_bar.dart';
import 'package:movie_app/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';

class SignupBlocListener extends StatelessWidget {
  const SignupBlocListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(color: Color(0xFFFFBB3B)),
            ),
          );
        } else if (state is SignupSuccess || state is SignupFailure) {
          if (Navigator.canPop(context)) Navigator.pop(context);
        }
        if (state is SignupSuccess) {
          CustomSnackBar.show(
            context: context,
            message: 'Account created! Check your email to verify.',
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.loginView,
            (route) => false,
          );
        }

        if (state is SignupFailure) {
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
