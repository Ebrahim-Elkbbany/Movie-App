import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipes/core/helpers/extensions.dart';
import 'package:food_recipes/core/helpers/responsive_spacing.dart';
import 'package:food_recipes/core/routing/routes.dart';
import 'package:food_recipes/core/theming/app_colors.dart';
import 'package:food_recipes/core/theming/font_styles.dart';
import 'package:food_recipes/core/theming/font_weight_helper.dart';
import 'package:food_recipes/core/widgets/custom_button.dart';
import 'package:food_recipes/core/widgets/custom_text_button.dart';
import 'package:food_recipes/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:food_recipes/features/auth/presentation/views/widgets/signup_bloc_listner.dart';
import 'package:food_recipes/features/auth/presentation/views/widgets/signup_text_fields_sec.dart';
import 'package:food_recipes/features/auth/presentation/views/widgets/signup_with_social_sec.dart';
import 'package:food_recipes/features/profile/presentation/manager/theme_cubit/theme_cubit.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLightTheme = ThemeCubit.get(context).isLightTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacer(30),
              Text(
                'Create an account',
                style: FontStyles.font20Black12Regular.copyWith(
                  fontWeight: FontWeightHelper.semiBold,
                  color: isLightTheme
                      ? AppColors.kBlackColor
                      : AppColors.kWhiteColor,
                ),
              ),
              verticalSpacer(5),
              Text(
                'Let’s help you set up your account, \nit won’t take long.',
                style: FontStyles.font20Black12Regular.copyWith(
                  fontSize: 11.sp,
                  color: isLightTheme ? null : AppColors.kWhiteColor,
                ),
              ),
              verticalSpacer(20),
              const SignupTextFieldSec(),
              verticalSpacer(40),
              CustomButton(
                buttonName: 'Sign up',
                onPressed: () {
                  if (context
                      .read<SignupCubit>()
                      .formKey
                      .currentState!
                      .validate()) {
                    context.read<SignupCubit>().signupWithEmail(context);
                  }
                },
              ),
              verticalSpacer(23),
              const SignupWithSocialSec(),
              verticalSpacer(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a member?',
                    style: FontStyles.font11kSecondaryColorRegular.copyWith(
                      color: isLightTheme ? null : AppColors.kWhiteColor,
                    ),
                  ),
                  CustomTextButton(
                    text: ' Sign In',
                    onPressed: () {
                      context.pushReplacementNamed(Routes.loginView);
                    },
                  ),
                ],
              ),
              verticalSpacer(20),
              const SignupBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
