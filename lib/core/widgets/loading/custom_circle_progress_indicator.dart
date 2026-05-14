import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';

class CustomCircleProgressIndicator extends StatelessWidget {
  final double? size;
  final Color? color;
  final double strokeWidth;

  const CustomCircleProgressIndicator({
    super.key,
    this.size,
    this.color,
    this.strokeWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size ?? 40.h,
        width: size ?? 40.h,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: color ?? context.customColors.primary,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
