import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';

class RetryButton extends StatelessWidget {
  const RetryButton({super.key, this.onPressed});

  final void Function()? onPressed;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        backgroundColor: context.customColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        'Try Again',
        style: TextStyle(
          color: context.customColors.textPrimary,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
