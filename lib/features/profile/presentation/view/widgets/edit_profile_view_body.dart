import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/navigation/app_routes.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/core/widgets/feedback/custom_snack_bar.dart';
import 'package:movie_app/features/profile/presentation/manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:movie_app/features/profile/presentation/manager/edit_profile_cubit/edit_profile_state.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/edit_profile_action_buttons.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/edit_profile_avatar_section.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/edit_profile_form_section.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileUpdateSuccess) {
          CustomSnackBar.show(
            context: context,
            message: 'Profile updated successfully',
          );
          Navigator.pop(context, true);
        } else if (state is EditProfileUpdateError) {
          CustomSnackBar.show(
            context: context,
            message: state.message,
            isError: true,
          );
        } else if (state is EditProfileResetPasswordSuccess) {
          CustomSnackBar.show(
            context: context,
            message: state.message,
          );
        } else if (state is EditProfileResetPasswordError) {
          CustomSnackBar.show(
            context: context,
            message: state.message,
            isError: true,
          );
        } else if (state is EditProfileDeleteSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.loginView,
            (route) => false,
          );
        } else if (state is EditProfileDeleteError) {
          CustomSnackBar.show(
            context: context,
            message: state.message,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is EditProfileUpdateLoading ||
            state is EditProfileResetPasswordLoading ||
            state is EditProfileDeleteLoading;

        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: const Color(0xFFFFBB3B),
                          size: 24.sp,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Pick Avatar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFFFBB3B),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 24.w),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 32.h),
                          const EditProfileAvatarSection(),
                          SizedBox(height: 32.h),
                          const EditProfileFormSection(),
                          SizedBox(height: 32.h),
                        ],
                      ),
                    ),
                  ),
                  const EditProfileActionButtons(),
                ],
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(
                    color: context.customColors.primary,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
