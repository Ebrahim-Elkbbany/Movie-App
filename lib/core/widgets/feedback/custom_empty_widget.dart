import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/core/widgets/custom_text.dart';
import 'package:movie_app/core/widgets/feedback/retry_button.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.onRetry,
  });

  final String? title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: 80.sp,
              color: context.customColors.disabledColor,
            ),
            SizedBox(height: 16.h),
            CustomText(
              text: title ?? 'No data found',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              textColor: context.customColors.textPrimary,
            ),
            if (subtitle != null) ...[
              SizedBox(height: 8.h),
              CustomText(
                text: subtitle!,
                fontSize: 14.sp,
                textColor: context.customColors.textSecondary,
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              RetryButton(onPressed: onRetry),
            ],
          ],
        ),
      ),
    );
  }
}
