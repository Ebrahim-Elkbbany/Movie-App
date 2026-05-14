import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/generated/l10n.dart';

class RetryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const RetryButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.refresh),
      label: Text(s.Retry),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.customColors.primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
