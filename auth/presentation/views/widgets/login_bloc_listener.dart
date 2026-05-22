import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/helpers/extensions.dart';
import 'package:food_recipes/core/theming/app_colors.dart';
import 'package:food_recipes/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import '../../../../../core/routing/routes.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is LoginLoading ||
          current is LoginSuccess ||
          current is LoginFailure ||
          current is ResetPasswordLoading ||
          current is ResetPasswordSuccess ||
          current is ResetPasswordFailure,
      listener: (BuildContext context, state) {
        if (state is LoginLoading || state is ResetPasswordLoading) {
          showDialog(
            context: context,
            builder: (context) => Center(
              child: CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              ),
            ),
          );
        } else if (state is LoginSuccess) {
          context.pop();
          context.pushNamedAndRemoveUntil(
            Routes.layoutView,
            predicate: (route) => false,
          );
        } else if (state is LoginFailure) {
          context.pop();
          setupErrorState(context, state.error);
        }else if (state is ResetPasswordFailure) {
          context.pop();
          setupErrorState(context, state.error);
        }else if (state is ResetPasswordSuccess) {
          context.pop();
          setupSuccessState(context, state.message);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      desc: error,
    ).show();
  }

  void setupSuccessState(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      desc: message,
    ).show();
  }
}
