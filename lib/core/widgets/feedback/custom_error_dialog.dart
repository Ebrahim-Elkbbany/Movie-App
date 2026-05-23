import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/core/widgets/buttons/custom_text_button.dart';
import 'package:movie_app/core/widgets/custom_text.dart';

class CustomErrorDialog extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;

  const CustomErrorDialog({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.customColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Row(
        children: [
          Icon(Icons.error_outline, color: context.customColors.error, size: 28.sp),
          SizedBox(width: 8.w),
          CustomText(
            text: 'Error',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            textColor: context.customColors.error,
          ),
        ],
      ),
      content: CustomText(
        text: errorMessage,
        fontSize: 16.sp,
        textColor: context.customColors.textPrimary,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextButton(
              text: 'Close',
              onPressed: () => Navigator.pop(context),
              color: context.customColors.textSecondary,
            ),
            if (onRetry != null) ...[
              SizedBox(width: 8.w),
              CustomTextButton(
                text: 'Retry',
                onPressed: () {
                  Navigator.pop(context);
                  onRetry!();
                },
                color: context.customColors.error,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
