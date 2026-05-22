import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/navigation/app_routes.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';
import 'package:movie_app/core/utils/constants/assets_paths.dart';
import 'package:movie_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:movie_app/features/auth/presentation/view/widgets/auth_google_button.dart';
import 'package:movie_app/features/auth/presentation/view/widgets/auth_or_divider.dart';
import 'package:movie_app/features/auth/presentation/view/widgets/login_form.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 60.h),
            Image.asset(
              AssetsPaths.logo,
              height: 120.h,
              width: 120.w,
            ),
            SizedBox(height: 48.h),
            const LoginForm(),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't Have Account ? ",
                  style: FontStyles.font14.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.registerView),
                  child: Text(
                    'Create One',
                    style: FontStyles.font14.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            const AuthOrDivider(),
            SizedBox(height: 20.h),
            AuthGoogleButton(
              onPressed: () => context.read<LoginCubit>().loginWithGoogle(),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

