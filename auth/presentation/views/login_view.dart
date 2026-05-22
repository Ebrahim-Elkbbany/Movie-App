import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipes/core/helpers/responsive_spacing.dart';
import 'package:food_recipes/core/theming/app_colors.dart';
import 'package:food_recipes/core/theming/font_styles.dart';
import 'package:food_recipes/features/auth/presentation/views/widgets/login_bloc_listener.dart';
import 'package:food_recipes/features/auth/presentation/views/widgets/login_dont_have_account_sec.dart';
import 'package:food_recipes/features/auth/presentation/views/widgets/login_forget_pass_and_button_sec.dart';
import 'package:food_recipes/features/auth/presentation/views/widgets/login_text_fields_sec.dart';
import 'package:food_recipes/features/auth/presentation/views/widgets/login_with_social.dart';

import 'package:food_recipes/features/profile/presentation/manager/theme_cubit/theme_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLightTheme =ThemeCubit.get(context).isLightTheme;
    ThemeCubit.get(context).getLocalNotification(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacer(50),
              Text(
                'Hello,',
                style: FontStyles.font30BlackSemiBold.copyWith(
                  color: isLightTheme? null : AppColors.kWhiteColor
                ),
              ),
              Text(
                'Welcome Back!',
                style: FontStyles.font20Black12Regular.copyWith(
                    color: isLightTheme? null : AppColors.kWhiteColor
                ),
              ),
              verticalSpacer(57),
              const LoginTextFieldSec(),
              verticalSpacer(20),
              const LoginForgetPassAndButtonSec(),
              verticalSpacer(23),
              const LoginWithSocialSec(),
              verticalSpacer(55),
              const LoginDontHaveAccountSec(),
              const LoginBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
