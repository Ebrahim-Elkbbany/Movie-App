import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/core/widgets/buttons/custom_text_button.dart';
import 'package:movie_app/core/widgets/feedback/error_icon.dart';
import 'package:movie_app/core/widgets/feedback/error_text.dart';
import 'package:movie_app/generated/l10n.dart';

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
    final s = S.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: context.customColors.surface,
      contentPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ErrorIcon(),
          context.gapH(16),
          ErrorText(message: errorMessage),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextButton(
              text: s.close,
              onPressed: () => Navigator.pop(context),
              color: context.customColors.textSecondary,
            ),
            if (onRetry != null) ...[
              context.gapW(8),
              CustomTextButton(
                text: s.Retry,
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
