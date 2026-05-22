import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/helpers/app_regex.dart';
import 'package:food_recipes/core/helpers/responsive_spacing.dart';
import 'package:food_recipes/core/theming/app_colors.dart';
import 'package:food_recipes/core/theming/font_styles.dart';
import 'package:food_recipes/core/widgets/app_text_form_field.dart';
import 'package:food_recipes/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import '../../../../profile/presentation/manager/theme_cubit/theme_cubit.dart';

class LoginTextFieldSec extends StatelessWidget {
  const LoginTextFieldSec({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLightTheme =ThemeCubit.get(context).isLightTheme;
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: FontStyles.font14Black12Regular.copyWith(
                color: isLightTheme? null : AppColors.kWhiteColor
            ),
          ),
          verticalSpacer(5),
          AppTextFormField(
            controller: context.read<LoginCubit>().email,
            hintText: 'Enter Email',
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
            },
          ),
          verticalSpacer(30),
          Text(
            'Enter Password',
            style: FontStyles.font14Black12Regular.copyWith(
                color: isLightTheme? null : AppColors.kWhiteColor
            ),
          ),
          verticalSpacer(5),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return AppTextFormField(
                controller: context.read<LoginCubit>().password,
                hintText: 'Enter Password',
                isObscureText: context.read<LoginCubit>().isPassword,
                suffixIconTap: () {
                  context.read<LoginCubit>().changePasswordVisibility();
                },
                suffixIcon: context.read<LoginCubit>().suffix,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
