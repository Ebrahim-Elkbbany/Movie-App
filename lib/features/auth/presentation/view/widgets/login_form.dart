import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/navigation/app_routes.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/core/widgets/buttons/custom_button.dart';
import 'package:movie_app/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:movie_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _emailController,
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
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (p, c) => c is LoginPasswordVisibilityChanged,
            builder: (context, state) {
              final cubit = context.read<LoginCubit>();
              return CustomTextFormField(
                controller: _passwordController,
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
                  if (v == null || v.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              );
            },
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.forgetPasswordView),
              child: Text(
                'Forget Password ?',
                style: FontStyles.font14.copyWith(
                  color: colors.primary,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          CustomButton(
            buttonName: 'Login',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginCubit>().login(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}
