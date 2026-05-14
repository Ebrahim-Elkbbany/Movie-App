import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/login/presentation/manager/login_cubit.dart';

class LoginListenerSec extends StatelessWidget {
  const LoginListenerSec({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen:
          (previous, current) =>
              current is LoginSuccess ||
              current is LoginLoading ||
              current is LoginFailure,
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            },
          );
        }
        if (state is LoginFailure) {
          Navigator.pop(context);
          // customErrorDialog(context, state.errorMessage);
        }
        if (state is LoginSuccess) {
          Navigator.pop(context);
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   AppRoutes.home,
          //   (route) => false,
          // );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
