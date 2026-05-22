import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/helpers/responsive_spacing.dart';
import 'package:food_recipes/core/theming/font_styles.dart';
import 'package:food_recipes/core/widgets/face_google_container.dart';
import 'package:food_recipes/features/auth/presentation/manager/login_cubit/login_cubit.dart';

class LoginWithSocialSec extends StatelessWidget {
  const LoginWithSocialSec({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          children: [
            const Expanded(
                child: Divider(
                  indent: 30,
                  endIndent: 10,
                )),
            Text(
              'Or Sign in With',
              style: FontStyles.font11WhiteD9Medium,
            ),
            const Expanded(
                child: Divider(
                  indent: 10,
                  endIndent: 30,
                )),
          ],
        ),
        verticalSpacer(23),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             CustomFaceGoogleContainer(isGoogle: true,onTap: () {
              context.read<LoginCubit>().loginWithGoogle();
            },),
            horizontalSpacer(24),
            const CustomFaceGoogleContainer(isGoogle: false),
          ],
        ),
      ],
    );
  }
}
