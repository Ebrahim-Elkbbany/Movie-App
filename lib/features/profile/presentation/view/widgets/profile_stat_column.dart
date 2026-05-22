import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';

class ProfileStatColumn extends StatelessWidget {
  final String count;
  final String label;

  const ProfileStatColumn({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          style: FontStyles.font24Bold.copyWith(
            fontSize: 36.sp,
            color: colors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: FontStyles.font18Bold.copyWith(
            color: colors.textPrimary,
            fontSize: 20.sp,
          ),
        ),
      ],
    );
  }
}
