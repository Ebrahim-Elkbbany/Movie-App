import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';

class CustomCastItem extends StatelessWidget {
  final String image;
  final String name;
  final String character;

  const CustomCastItem({
    super.key,
    required this.image,
    required this.name,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColorsExtension.dark.surface,
        borderRadius: BorderRadius.circular(20.r),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              imageUrl: image,
              width: 72.w,
              height: 72.h,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name : $name",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                SizedBox(height: 10.h),

                Text(
                  "Character : $character",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
