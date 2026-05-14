import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/core/widgets/buttons/custom_button.dart';
import 'package:movie_app/core/widgets/custom_text.dart';
import 'package:movie_app/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:movie_app/features/login/presentation/manager/login_cubit.dart';
import 'package:movie_app/generated/l10n.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;
  bool isPassword = true;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: emailController,
            hintText: s.emailHint,
            prefixIcon: Icons.email_outlined,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                return s.invalidEmail;
              }
              return null;
            },
          ),
          context.gapH(16),
          CustomTextFormField(
            controller: passwordController,
            hintText: s.passwordHint,
            isObscureText: isPassword,
            prefixIcon: Icons.lock_outline,
            suffixIcon: isPassword ? Icons.visibility : Icons.visibility_off,
            suffixIconTap: () {
              setState(() {
                isPassword = !isPassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return s.invalidPassword;
              }
              return null;
            },
          ),
          context.gapH(16),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(4.r),
              onTap: () {
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
                child: CustomText(
                  text: s.forgotPassword,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          context.gapH(24),
          CustomButton(
            buttonName: s.login,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<LoginCubit>().login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}
