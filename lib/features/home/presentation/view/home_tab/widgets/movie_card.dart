import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/movies_rating.dart';

class MoviesCard extends StatelessWidget {
  final MovieModel movie;

  const MoviesCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.r),
      child: Stack(
        children: [
          /// IMAGE
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: movie.imageUrl,
              fit: BoxFit.cover,
            ),
          ),

          /// RATING
          MovieRatingBadge(rating: movie.rating),
        ],
      ),
    );
  }
}
