import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:movie_app/features/profile/presentation/manager/edit_profile_cubit/edit_profile_cubit.dart';

class EditProfileFormSection extends StatelessWidget {
  const EditProfileFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: cubit.nameController,
          hintText: 'Name',
          prefixWidget: Icon(
            Icons.person,
            color: Colors.white,
            size: 24.sp,
          ),
          keyboardType: TextInputType.name,
        ),
        SizedBox(height: 16.h),
        CustomTextFormField(
          controller: cubit.phoneController,
          hintText: 'Phone Number',
          prefixWidget: Icon(
            Icons.phone,
            color: Colors.white,
            size: 24.sp,
          ),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 20.h),
        GestureDetector(
          onTap: () => cubit.resetPassword(),
          child: Text(
            'Reset Password',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
