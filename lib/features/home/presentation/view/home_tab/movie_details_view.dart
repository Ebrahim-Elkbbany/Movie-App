import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_weight_helper.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/core/utils/constants/app_constants.dart';
import 'package:movie_app/core/widgets/buttons/custom_bottom_button.dart';
import 'package:movie_app/features/home/presentation/manager/movies_details_cubit.dart';
import 'package:movie_app/features/home/presentation/manager/movies_details_state.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/movie_screen_shot_item.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/custom_item_cast.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/movie_details_header.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/movie_stats_section.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/section_title.dart';

class MovieDetailsView extends StatelessWidget {
  final int id;

  const MovieDetailsView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MoviesDetailsCubit>()..fetchMoviesDetails(id: id),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30.w,
              color: AppColorsExtension.light.textPrimary,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppIcons.saved),
            ),
          ],
        ),
        body: BlocBuilder<MoviesDetailsCubit, MoviesDetailsState>(
          builder: (context, state) {
            if (state is MoviesDetailsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MoviesDetailsErrorState) {
              return Center(child: Text(state.message));
            }

            if (state is MoviesDetailsLoadedState) {
              final movie = state.movieDetails;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieDetailsHeader(movie: movie),
                    CustomBottomButton(
                      text: AppConstants.watch,
                      onPressed: () {},
                      backgroundColor: AppColorsExtension.light.error,
                      textStyle: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                    MovieStatsSection(movie: movie),
                    SectionTitle(title: AppConstants.screenshots),

                    Column(
                      children: movie.screenshots.map((image) {
                        return MovieScreenshotItem(imageUrl: image);
                      }).toList(),
                    ),
                    const SectionTitle(title: AppConstants.summary),

                    Padding(
                      padding: REdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Text(
                        movie.description,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeightHelper.regular,
                        ),
                      ),
                    ),
                    const SectionTitle(title: AppConstants.cast),
                    Column(
                      children: movie.cast.map((cast) {
                        return CustomCastItem(
                          image: cast.image,
                          name: cast.name,
                          character: cast.character,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.h),
                    const SectionTitle(title: AppConstants.genres),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 16.w,
                            runSpacing: 12.h,
                            children: movie.genres.map((genre) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 28.w,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColorsExtension.dark.surface,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Text(
                                  genre,
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(
                                        fontWeight: FontWeightHelper.regular,
                                      ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
