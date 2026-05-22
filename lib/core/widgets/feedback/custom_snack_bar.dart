import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final bgColor = isError ? colors.error : colors.primary;
    final textColor = isError ? Colors.white : Colors.black;
    final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: textColor, size: 24.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  message,
                  style: FontStyles.font14Bold.copyWith(color: textColor),
                ),
              ),
            ],
          ),
          backgroundColor: bgColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
