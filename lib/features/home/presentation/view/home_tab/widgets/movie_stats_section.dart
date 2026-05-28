
import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/features/home/data/models/movie_details.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/custom_info_container.dart';

class MovieStatsSection extends StatelessWidget {
  const MovieStatsSection({
    super.key,
    required this.movie,
  });

  final MovieDetailModel movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomInfoContainer(
            text: movie.likecount.toString(),
            icon: AppIcons.heart,
          ),
          CustomInfoContainer(
            text: movie.runtime.toString(),
            icon: AppIcons.clock,
          ),
          CustomInfoContainer(
            text: movie.rating.toString(),
            icon: AppIcons.star,
          ),
        ],
      ),
    );
  }
}
