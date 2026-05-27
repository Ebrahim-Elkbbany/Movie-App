import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';

class MovieRatingBadge extends StatelessWidget {
  final double rating;

  const MovieRatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10.h,
      left: 10.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColorsExtension.light.primary.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              rating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(width: 4.w),

            SvgPicture.asset(
              AppIcons.star,
              width: 15.w,
              height: 15.h,
              colorFilter: const ColorFilter.mode(
                Colors.amber,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
