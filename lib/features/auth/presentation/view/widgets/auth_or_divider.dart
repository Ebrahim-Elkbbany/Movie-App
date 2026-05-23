import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';

class AuthOrDivider extends StatelessWidget {
  const AuthOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100.w,
          child: Divider(color: colors.primary, thickness: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'OR',
            style: FontStyles.font14.copyWith(color: colors.primary),
          ),
        ),
        SizedBox(
          width: 100.w,
          child: Divider(color: colors.primary, thickness: 1),
        ),
      ],
    );
  }
}
