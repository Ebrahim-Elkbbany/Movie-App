import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipes/core/helpers/extensions.dart';
import 'package:food_recipes/core/routing/routes.dart';
import 'package:food_recipes/core/theming/app_colors.dart';
import 'package:food_recipes/core/theming/font_styles.dart';
import 'package:food_recipes/core/theming/font_weight_helper.dart';
import 'package:food_recipes/core/widgets/custom_text_button.dart';

import '../../../../profile/presentation/manager/theme_cubit/theme_cubit.dart';


class LoginDontHaveAccountSec extends StatelessWidget {
  const LoginDontHaveAccountSec({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLightTheme =ThemeCubit.get(context).isLightTheme;
    return    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don’t have an account?',
          style: FontStyles.font30BlackSemiBold
              .copyWith(
            fontSize: 11.sp,
         color: isLightTheme? null :AppColors.kWhiteColor,
            fontWeight: FontWeightHelper.regular,
          ),
        ),
        CustomTextButton(
          text: '  Sign up',
          onPressed: () {
            context.pushReplacementNamed(Routes.signupView);
          },
        ),
      ],
    );
  }
}
