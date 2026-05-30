import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/movies_rating.dart';

class MoviesCard extends StatelessWidget {
  final MovieModel movie;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  MoviesCard({
    super.key,
    this.onTap,
    required this.movie,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

  borderRadius: BorderRadius.circular(20.r),

      child: SizedBox(
        width: width ?? double.infinity,
        height: height ?? 275.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: movie.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              MovieRatingBadge(rating: movie.rating),
            ],
          ),
        ),
      ),
    );
  }
}
