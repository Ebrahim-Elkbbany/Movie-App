import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/features/home/presentation/manager/movies_cubit.dart';
import 'package:movie_app/features/home/presentation/manager/movies_states.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/movie_card.dart';

class HomeContent extends StatelessWidget {
  final MoviesLoaded state;

  const HomeContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final movies = state.movies;
    final featured = movies.take(10).toList();
    final currentMovie = featured[state.currentIndex];

    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: currentMovie.imageUrl,
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColorsExtension.light.primary.withValues(alpha: 0.6),
                    AppColorsExtension.light.primary,
                  ],
                ),
              ),
            ),
          ),

          // CONTENT
          Column(
            children: [
              Image.asset(AppImages.availableNow, width: 263.w),

              CarouselSlider(
                items: featured.map((movie) {
                  return MoviesCard(movie: movie);
                }).toList(),
                options: CarouselOptions(
                  height: 352.h,
                  viewportFraction: 0.55,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.36,
                  initialPage: 0,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  scrollPhysics: const BouncingScrollPhysics(),
                  onPageChanged: (index, reason) {
                    context.read<MoviesCubit>().changeIndex(index);
                  },
                ),
              ),

              Image.asset(AppImages.watchNow, width: 320.w),
            ],
          ),
        ],
      ),
    );
  }
}
