import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';

class CustomInfoContainer extends StatelessWidget {
  final String text;
  final String icon;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  const CustomInfoContainer({
    super.key,
    required this.text,
    required this.icon,
    this.backgroundColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47.h,
      width: 120.w,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColorsExtension.dark.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(icon, width: 25.w, height: 25.h),

            Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
