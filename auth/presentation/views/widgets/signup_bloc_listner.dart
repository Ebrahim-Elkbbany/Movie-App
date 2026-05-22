import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/helpers/extensions.dart';
import 'package:food_recipes/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import '../../../../../core/theming/app_colors.dart';

class SignupBlocListener extends StatelessWidget {
  const SignupBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listenWhen: (previous, current) =>
          current is SignupLoading ||
          current is SignupSuccess ||
          current is SignupFailure,
      listener: (context, state) {
        if (state is SignupLoading) {
          showDialog(
            builder: (context) => Center(
              child: CircularProgressIndicator(color: AppColors.kPrimaryColor),
            ),
            context: context,
          );
        } else if (state is SignupSuccess) {
          context.pop();
        } else if (state is SignupFailure) {
          context.pop();
          setupErrorState(context, state.error);
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

}
