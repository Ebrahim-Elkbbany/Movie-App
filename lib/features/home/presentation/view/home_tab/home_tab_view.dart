import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';

import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/features/home/presentation/manager/movies_cubit.dart';
import 'package:movie_app/features/home/presentation/manager/movies_states.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MoviesError) {
          return Center(child: Text(state.message));
        }

        if (state is MoviesLoaded) {
          final movies = state.movies;
          final featured = movies.take(10).toList();

          return SingleChildScrollView(
            child: Stack(
              children: [
                /// BACKGROUND IMAGE
                SizedBox(
                  height: 645.h,
                  width: double.infinity,
                  child: Image.asset(AppImages.onBoarding6, fit: BoxFit.cover),
                ),

                /// DARK OVERLAY
                Container(
                  height: 645.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColorsExtension.light.primary.withValues(alpha: 0.8),
                        AppColorsExtension.light.primary.withValues(
                          alpha: 0.60,
                        ),
                        AppColorsExtension.light.primary.withValues(alpha: 0.9),
                      ],
                      stops: const [0.0, 0.47, 1.0],
                    ),
                  ),
                ),

                /// CONTENT
                Column(
                  children: [
                    Image.asset(AppImages.availableNow, width: 263.w),

                    Padding(
                      padding: REdgeInsets.symmetric(vertical: 20.0),
                      child: CarouselSlider(
                        items: featured.map((movie) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18.r),
                              child: CachedNetworkImage(
                                imageUrl: movie.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,

                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),

                                errorWidget: (context, url, error) => Container(
                                  color: Colors.grey.shade900,
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),

                        options: CarouselOptions(
                          height: 352.h,
                          viewportFraction: 0.62,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          initialPage: 0,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration: const Duration(
                            milliseconds: 800,
                          ),
                          scrollPhysics: const BouncingScrollPhysics(),
                        ),
                      ),
                    ),

                    Image.asset(AppImages.watchNow, width: 320.w),
                  ],
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
