import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/widgets/buttons/custom_button.dart';
import 'package:movie_app/core/widgets/feedback/custom_confirmation_dialog.dart';
import 'package:movie_app/features/profile/presentation/manager/edit_profile_cubit/edit_profile_cubit.dart';

class EditProfileActionButtons extends StatelessWidget {
  const EditProfileActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final editCubit = context.read<EditProfileCubit>();

    return Column(
      children: [
        CustomButton(
          buttonName: 'Delete Account',
          backgroundColor: const Color(0xFFE82626),
          radius: 15,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          onPressed: () => _showDeleteConfirmation(context, editCubit),
        ),
        SizedBox(height: 16.h),
        CustomButton(
          buttonName: 'Update Data',
          backgroundColor: const Color(0xFFFFBB3B),
          radius: 15,
          textStyle: TextStyle(
            color: const Color(0xFF121312),
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          onPressed: () => editCubit.updateUserData(),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, EditProfileCubit editCubit) {
    CustomConfirmationDialog.show(
      context: context,
      title: 'Delete Account',
      message:
          'Are you sure you want to delete your account?\nThis action cannot be undone and all your data will be lost.',
      confirmText: 'Delete',
      cancelText: 'Cancel',
      icon: Icons.delete_forever,
      isDestructive: true,
      onConfirm: () => editCubit.deleteAccount(),
    );
  }
}
