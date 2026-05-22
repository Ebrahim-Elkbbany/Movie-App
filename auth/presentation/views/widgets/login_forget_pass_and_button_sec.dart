import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/helpers/responsive_spacing.dart';
import 'package:food_recipes/core/widgets/custom_button.dart';
import 'package:food_recipes/core/widgets/custom_text_button.dart';
import '../../manager/login_cubit/login_cubit.dart';

class LoginForgetPassAndButtonSec extends StatelessWidget {
  const LoginForgetPassAndButtonSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Align(
            alignment: Alignment.centerRight,
            child: CustomTextButton(
              text: 'Forgot Password?',
              onPressed: () {
                context.read<LoginCubit>().resetPassword();
              },
            )),
        verticalSpacer(25),
         CustomButton(buttonName: 'Sign In',onPressed: () {
          if(context.read<LoginCubit>().formKey.currentState!.validate()){
            context.read<LoginCubit>().loginWithEmail();
          }
        },),
      ],
    );
  }
}
