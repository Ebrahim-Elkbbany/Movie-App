import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/features/profile/presentation/manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:movie_app/features/profile/presentation/manager/edit_profile_cubit/edit_profile_state.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/avatar_picker_bottom_sheet.dart';

class EditProfileAvatarSection extends StatelessWidget {
  const EditProfileAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (previous, current) => current is EditProfileAvatarChanged,
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();
        return Center(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (_) => AvatarPickerBottomSheet(
                  selectedAvatar: cubit.selectedAvatarPath,
                  onAvatarSelected: (avatar) {
                    cubit.changeAvatar(avatar);
                  },
                ),
              );
            },
            child: SizedBox(
              width: 140.w,
              height: 140.w,
              child: Container(
                width: 140.w,
                height: 140.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    cubit.selectedAvatarPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
