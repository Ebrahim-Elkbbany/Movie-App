import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/helpers/app_regex.dart';
import 'package:food_recipes/core/helpers/responsive_spacing.dart';
import 'package:food_recipes/core/theming/app_colors.dart';
import 'package:food_recipes/core/theming/font_styles.dart';
import 'package:food_recipes/core/widgets/app_text_form_field.dart';
import '../../../../profile/presentation/manager/theme_cubit/theme_cubit.dart';
import '../../manager/signup_cubit/signup_cubit.dart';

class SignupTextFieldSec extends StatelessWidget {
  const SignupTextFieldSec({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLightTheme =ThemeCubit.get(context).isLightTheme;
    return BlocBuilder<SignupCubit, SignupState>(
  builder: (context, state) {
    return Form(
      key: context.read<SignupCubit>().formKey,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: FontStyles.font14Black12Regular.copyWith(
              color: isLightTheme? null :AppColors.kWhiteColor
            ),
          ),
          verticalSpacer(5),
          AppTextFormField(
            controller: context.read<SignupCubit>().name,
            hintText: 'Enter Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
            },
          ),
          verticalSpacer(20),
          Text(
            'Phone',
            style: FontStyles.font14Black12Regular.copyWith(
                color: isLightTheme? null :AppColors.kWhiteColor
            ),
          ),
          verticalSpacer(5),
          AppTextFormField(
            controller:  context.read<SignupCubit>().phone,
            hintText: 'Enter Phone Number',
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isPhoneNumberValid(value)) {
                return 'Please enter a valid number';
              }
            },
          ),
          verticalSpacer(20),
          Text(
            'Email',
            style: FontStyles.font14Black12Regular.copyWith(
                color: isLightTheme? null :AppColors.kWhiteColor
            ),
          ),
          verticalSpacer(5),
          AppTextFormField(
            controller:  context.read<SignupCubit>().email,
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
                color: isLightTheme? null :AppColors.kWhiteColor
            ),
          ),
          verticalSpacer(5),
          AppTextFormField(
            controller:  context.read<SignupCubit>().password,
            hintText: 'Enter Password',
            isObscureText: context.read<SignupCubit>().isPassword,
            suffixIcon: context.read<SignupCubit>().suffix,
            suffixIconTap: () {
              context.read<SignupCubit>().changePasswordVisibility();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
            },
          ),
          verticalSpacer(20),
          Text(
            'Confirm Password',
            style: FontStyles.font14Black12Regular.copyWith(
                color: isLightTheme? null :AppColors.kWhiteColor
            ),
          ),
          verticalSpacer(5),
          AppTextFormField(
            controller: context.read<SignupCubit>().confirmPassword,
            hintText: 'Retype Password',
            isObscureText: context.read<SignupCubit>().isPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }else if(context.read<SignupCubit>().confirmPassword.text != context.read<SignupCubit>().password.text ){
                return 'Passwords are not same';
              }
            },
          ),
        ],

      ),
    );
  },
);
  }
}
