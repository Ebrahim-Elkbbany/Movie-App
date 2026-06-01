
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/features/home/data/models/movie_details.dart';

class MovieDetailsHeader extends StatelessWidget {
  const MovieDetailsHeader({
    super.key,
    required this.movie,
  });

  final MovieDetailModel movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 640.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          movie.backgroundImage.isEmpty
              ? Container(color: Colors.grey[900])
              : CachedNetworkImage(
                  imageUrl: movie.backgroundImage,
                  fit: BoxFit.cover,
                ),
    
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColorsExtension.light.primary.withValues(
                    alpha: 0.2,
                  ),
                  AppColorsExtension.light.primary.withValues(
                    alpha: 0.99,
                  ),
                ],
              ),
            ),
          ),
          Image.asset(AppImages.play),
          Positioned(
            bottom: 10.h,
            child: Text(
              movie.year.toString(),
              style: Theme.of(context).textTheme.titleLarge!
                  .copyWith(
                    color:
                        AppColorsExtension.light.textSecondary,
                  ),
            ),
          ),
          Positioned(
            bottom: 50.h,
            child: Text(
              movie.title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
