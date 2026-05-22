import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/font_styles.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/core/widgets/buttons/custom_button.dart';
import 'package:movie_app/core/widgets/buttons/custom_outline_button.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final IconData icon;
  final Color? iconColor;
  final Color? confirmColor;
  final VoidCallback onConfirm;
  final bool isDestructive;

  const CustomConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.onConfirm,
    this.cancelText = 'Cancel',
    this.icon = Icons.info_outline,
    this.iconColor,
    this.confirmColor,
    this.isDestructive = false,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,
    String cancelText = 'Cancel',
    IconData icon = Icons.info_outline,
    Color? iconColor,
    Color? confirmColor,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (_) => CustomConfirmationDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        onConfirm: onConfirm,
        cancelText: cancelText,
        icon: icon,
        iconColor: iconColor,
        confirmColor: confirmColor,
        isDestructive: isDestructive,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final effectiveIconColor =
        iconColor ?? (isDestructive ? colors.error : colors.primary);
    final effectiveConfirmColor =
        confirmColor ?? (isDestructive ? colors.error : colors.primary);

    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      elevation: 16,
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: effectiveIconColor.withValues(alpha: 0.12),
              ),
              child: Icon(
                icon,
                color: effectiveIconColor,
                size: 32.sp,
              ),
            ),
            SizedBox(height: 20.h),

            Text(
              title,
              style: FontStyles.font20SemiBold.copyWith(
                color: colors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),

            Text(
              message,
              style: FontStyles.font14Regular.copyWith(
                color: colors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28.h),

            Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    buttonName: cancelText,
                    borderColor: colors.textSecondary,
                    textStyle: FontStyles.font16Bold.copyWith(
                      color: colors.textSecondary,
                    ),
                    height: 48.h,
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomButton(
                    buttonName: confirmText,
                    backgroundColor: effectiveConfirmColor,
                    textStyle: FontStyles.font16Bold.copyWith(
                      color: isDestructive ? Colors.white : Colors.black,
                    ),
                    height: 48.h,
                    onPressed: () {
                      Navigator.pop(context, true);
                      onConfirm();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
