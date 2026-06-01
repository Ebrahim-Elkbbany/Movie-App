import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';

class ProfileAvatarAndName extends StatelessWidget {
  final UserModel user;

  const ProfileAvatarAndName({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Column(
      children: [
        CircleAvatar(
          radius: 59.r, 
          backgroundImage: _getAvatarImage(user.avatarPath),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(height: 12.h),
        Text(
          user.name,
          style: FontStyles.font18Bold.copyWith(color: colors.textPrimary),
        ),
      ],
    );
  }

  ImageProvider _getAvatarImage(String path) {
    if (path.isEmpty) return const AssetImage(AppImages.avatar1);
    return AssetImage(path);
  }
}
