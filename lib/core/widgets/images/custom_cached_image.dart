import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/widgets/loading/custom_shimmer.dart';
import 'image_error_placeholder.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxFit? fit;
  final BoxShape shape;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius,
    this.fit,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height?.h,
      width: width?.w,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: shape == BoxShape.rectangle
              ? BorderRadius.circular(borderRadius?.r ?? 12.r)
              : null,
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => shape == BoxShape.circle
          ? CustomShimmer.circle(height: height, width: width)
          : CustomShimmer(
              height: height,
              width: width,
              borderRadius: borderRadius,
            ),
      errorWidget: (context, url, error) => ImageErrorPlaceholder(
        shape: shape,
        height: height,
        width: width,
        borderRadius: borderRadius,
      ),
    );
  }
}
