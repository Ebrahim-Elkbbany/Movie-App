import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  const CustomShimmer.circle({
    super.key,
    this.height,
    this.width,
  })  : borderRadius = null,
        shape = BoxShape.circle;

  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.customColors.surface,
      highlightColor: context.customColors.background,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: context.customColors.surface,
          shape: shape,
          borderRadius: shape == BoxShape.rectangle
              ? BorderRadius.circular(borderRadius ?? 4.r)
              : null,
        ),
      ),
    );
  }
}
