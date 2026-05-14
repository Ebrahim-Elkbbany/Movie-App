import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/core/widgets/buttons/button_loading_indicator.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.buttonName,
    this.onPressed,
    this.height,
    this.width,
    this.radius,
    this.textStyle,
    this.borderColor,
    this.isLoading = false,
    this.icon,
  });

  final String buttonName;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final double? radius;
  final TextStyle? textStyle;
  final Color? borderColor;
  final bool isLoading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = borderColor ?? context.customColors.primary;
    return SizedBox(
      height: height ?? 52.h,
      width: width ?? double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: effectiveColor, width: 1.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius?.r ?? 12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        child: isLoading
            ? ButtonLoadingIndicator(color: effectiveColor)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[icon!, SizedBox(width: 8.w)],
                  Text(
                    buttonName,
                    style:
                        textStyle ??
                        context.textTheme.titleMedium?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: effectiveColor,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
