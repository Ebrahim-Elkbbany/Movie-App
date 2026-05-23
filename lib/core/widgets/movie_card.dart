import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/font_styles.dart';

class MovieCard extends StatelessWidget {
  final Map<String, dynamic>? movieData;
  const MovieCard({super.key, this.movieData});

  @override
  Widget build(BuildContext context) {
    final imageUrl = movieData?['image_url'] ?? 'https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg';
    final rating = movieData?['rating']?.toString() ?? '7.7';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8.h,
            left: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Text(
                    rating,
                    style: FontStyles.font14Bold.copyWith(color: Colors.white),
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
    );
  }
}
