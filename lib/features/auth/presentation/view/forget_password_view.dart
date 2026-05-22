import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';
import 'package:movie_app/core/utils/constants/assets_paths.dart';
import 'package:movie_app/core/widgets/buttons/custom_button.dart';
import 'package:movie_app/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:movie_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:movie_app/features/auth/presentation/view/widgets/forget_password_bloc_listener.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: colors.primary, size: 24.r),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Forget Password',
          style: FontStyles.font18Bold.copyWith(color: colors.primary),
        ),
        centerTitle: true,
      ),
      body: ForgetPasswordBlocListener(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Image.asset(AssetsPaths.forgetPasswordImage, height: 260.h),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixWidget: Padding(
                    padding: EdgeInsets.all(14.r),
                    child: SvgPicture.asset(
                      AssetsPaths.emailIcon,
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
                SizedBox(height: 24.h),
                CustomButton(
                  buttonName: 'Verify Email',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginCubit>().resetPassword(
                            email: _emailController.text,
                          );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

