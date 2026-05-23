import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/core/widgets/buttons/custom_button.dart';
import 'package:movie_app/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:movie_app/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: nameController,
            hintText: 'Name',
            prefixWidget: Padding(
              padding: EdgeInsets.all(14.r),
              child: SvgPicture.asset(
                AppIcons.user,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  colors.iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Name is required' : null,
          ),
          SizedBox(height: 16.h),
          CustomTextFormField(
            controller: emailController,
            hintText: 'Email',
            prefixWidget: Padding(
              padding: EdgeInsets.all(14.r),
              child: SvgPicture.asset(
                AppIcons.email,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  colors.iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                return 'Invalid email';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          BlocBuilder<SignupCubit, SignupState>(
            buildWhen: (p, c) => c is SignupPasswordVisibilityChanged,
            builder: (context, state) {
              final cubit = context.read<SignupCubit>();
              return CustomTextFormField(
                controller: passwordController,
                hintText: 'Password',
                prefixWidget: Padding(
                  padding: EdgeInsets.all(14.r),
                  child: SvgPicture.asset(
                    AppIcons.lock,
                    width: 20.w,
                    height: 20.h,
                    colorFilter: ColorFilter.mode(
                      colors.iconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                isObscureText: !cubit.isPasswordVisible,
                suffixWidget: IconButton(
                  icon: Icon(
                    cubit.isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: colors.iconColor,
                    size: 20.r,
                  ),
                  onPressed: cubit.togglePasswordVisibility,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password is required';
                  if (v.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              );
            },
          ),
          SizedBox(height: 16.h),
          BlocBuilder<SignupCubit, SignupState>(
            buildWhen: (p, c) => c is SignupConfirmPasswordVisibilityChanged,
            builder: (context, state) {
              final cubit = context.read<SignupCubit>();
              return CustomTextFormField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                prefixWidget: Padding(
                  padding: EdgeInsets.all(14.r),
                  child: SvgPicture.asset(
                    AppIcons.lock,
                    width: 20.w,
                    height: 20.h,
                    colorFilter: ColorFilter.mode(
                      colors.iconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                isObscureText: !cubit.isConfirmPasswordVisible,
                suffixWidget: IconButton(
                  icon: Icon(
                    cubit.isConfirmPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: colors.iconColor,
                    size: 20.r,
                  ),
                  onPressed: cubit.toggleConfirmPasswordVisibility,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (v != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              );
            },
          ),
          SizedBox(height: 16.h),
          CustomTextFormField(
            controller: phoneController,
            hintText: 'Phone Number',
            prefixWidget: Padding(
              padding: EdgeInsets.all(14.r),
              child: SvgPicture.asset(
                AppIcons.phone,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  colors.iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            keyboardType: TextInputType.phone,
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Phone number is required' : null,
          ),
          SizedBox(height: 24.h),
          CustomButton(
            buttonName: 'Create Account',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<SignupCubit>().signup(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      phone: phoneController.text,
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}
