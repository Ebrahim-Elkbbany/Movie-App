import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/navigation/app_routes.dart';
import 'package:movie_app/core/theming/font_styles.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/core/widgets/buttons/custom_button.dart';
import 'package:movie_app/core/widgets/feedback/custom_confirmation_dialog.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';

class ProfileActionButtons extends StatelessWidget {
  final UserModel user;

  const ProfileActionButtons({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: SizedBox(
              height: 56.h,
              child: CustomButton(
                buttonName: 'Edit Profile',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.editProfileView,
                    arguments: user,
                  ).then((value) {
                    if (value == true) {
                      if (!context.mounted) return;
                      context.read<ProfileCubit>().fetchUserData();
                    }
                  });
                },
                backgroundColor: colors.primary,
                textStyle: FontStyles.font18Bold.copyWith(
                  color: Colors.black,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          Expanded(
            flex: 4,
            child: SizedBox(
              height: 56.h,
              child: ElevatedButton(
                onPressed: () => _showLogoutDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Exit',
                      style: FontStyles.font18Bold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    const Icon(Icons.logout, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    CustomConfirmationDialog.show(
      context: context,
      title: 'Log Out',
      message: 'Are you sure you want to log out of your account?',
      confirmText: 'Log Out',
      cancelText: 'Stay',
      icon: Icons.logout_rounded,
      isDestructive: true,
      onConfirm: () {
        if (!context.mounted) return;
        context.read<ProfileCubit>().logout();
      },
    );
  }
}
