import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';

class ImageErrorPlaceholder extends StatelessWidget {
  final BoxShape shape;
  final double? height;
  final double? width;
  final double? borderRadius;

  const ImageErrorPlaceholder({
    super.key,
    required this.shape,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?.h,
      width: width?.w,
      decoration: BoxDecoration(
        color: context.customColors.disabledColor.withValues(alpha: 0.05),
        shape: shape,
        borderRadius: shape == BoxShape.rectangle 
            ? BorderRadius.circular(borderRadius?.r ?? 12.r) 
            : null,
      ),
      child: Icon(
        Icons.broken_image_outlined,
        color: context.customColors.disabledColor,
        size: 24.sp,
      ),
    );
  }
}
