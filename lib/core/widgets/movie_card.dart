import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/font_styles.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';

class MovieCard extends StatelessWidget {
  final Map<String, dynamic>? movieData;
  final VoidCallback? onTap;

  const MovieCard({super.key, this.movieData, this.onTap});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = movieData?['backgroundImage'] ?? '';
    final String rating =
        (movieData?['rating'] ?? 0.0).toString();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: context.customColors.surface,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            imageUrl.isEmpty
                ? const Center(child: Icon(Icons.broken_image))
                : CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.broken_image),
                    ),
                  ),
            Positioned(
              top: 8.h,
              left: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rating,
                      style:
                          FontStyles.font14Bold.copyWith(color: Colors.white),
                    ),
                    SizedBox(width: 4.w),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
