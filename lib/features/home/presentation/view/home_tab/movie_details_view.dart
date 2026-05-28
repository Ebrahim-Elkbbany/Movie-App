import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/custom_info_container.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/custom_item_cast.dart';

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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 640.h,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
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
                    ),
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
                    Padding(
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
                    ),
                    Padding(
                      padding: REdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Text(
                        AppConstants.screenShots,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: movie.screenshots.length,
                      itemBuilder: (context, index) {
                        return MovieScreenshotItem(
                          imageUrl: movie.screenshots[index],
                        );
                      },
                    ),
                    Padding(
                      padding: REdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Text(
                        AppConstants.summary,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
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
                    Padding(
                      padding: REdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Text(
                        AppConstants.cast,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,

                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: movie.cast.length,
                      itemBuilder: (context, index) {
                        final cast = movie.cast[index];

                        return CustomCastItem(
                          image: cast.image,
                          name: cast.name,
                          character: cast.character,
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        AppConstants.genres,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
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
