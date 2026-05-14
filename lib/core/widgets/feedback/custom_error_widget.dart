import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/generated/l10n.dart';
import 'error_back_button.dart';
import 'error_icon.dart';
import 'error_text.dart';
import 'retry_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final VoidCallback? onBackTap;
  final String? errorMessage;
  final bool hasBackButton;

  const CustomErrorWidget({
    super.key,
    this.onRetry,
    this.onBackTap,
    this.errorMessage,
    this.hasBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Stack(
      children: [
        if (hasBackButton) ErrorBackButton(onTap: onBackTap),

        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ErrorIcon(),
              SizedBox(height: 12.h),
              ErrorText(
                message: errorMessage ?? s.somethingWentWrong,
              ),
              SizedBox(height: 20.h),
              RetryButton(onPressed: onRetry),
            ],
          ),
        ),
      ],
    );
  }
}
