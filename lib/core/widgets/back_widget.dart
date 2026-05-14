import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/navigation/navigation_context_extension.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';

class BackWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;

  const BackWidget({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: GestureDetector(
        onTap: onTap ?? () => context.pop(),
        child: Container(
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(
            color: backgroundColor ?? context.customColors.disabledColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.sp,
            color: iconColor ?? context.customColors.primary,
          ),
        ),
      ),
    );
  }
}
