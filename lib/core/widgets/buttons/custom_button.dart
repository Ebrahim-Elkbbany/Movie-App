import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/core/widgets/buttons/button_loading_indicator.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
    this.onPressed,
    this.height,
    this.width,
    this.radius,
    this.textStyle,
    this.backgroundColor,
    this.isLoading = false,
  });

  final String buttonName;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final double? radius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 54.h,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? context.customColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius?.r ?? 12.r),
          ),
        ),
        child: isLoading
            ? ButtonLoadingIndicator(color: context.customColors.textPrimary)
            : Text(
                buttonName,
                style: textStyle ??
                    context.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF282A28),
                      fontWeight: FontWeight.bold,
                    ),
              ),
      ),
    );
  }
}
