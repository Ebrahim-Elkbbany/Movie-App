import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/constants/app_constants.dart';

import 'package:movie_app/features/home/presentation/manager/movies_cubit.dart';
import 'package:movie_app/features/home/presentation/manager/movies_states.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/home_tab_content.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/movie_card.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  bool showAllCategories = false;

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
          final category = state.categories[state.currentCategoryIndex];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                HomeContent(state: state),

                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      TextButton(
                        onPressed: () {
                          setState(() {
                            showAllCategories = !showAllCategories;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              showAllCategories
                                  ? AppConstants.showLess
                                  : AppConstants.seeMore,
                            ),
                            SizedBox(width: 4.w),
                            Icon(Icons.arrow_forward, size: 12.w),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                showAllCategories
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: category.movies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.65,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                        itemBuilder: (context, index) {
                          return MoviesCard(movie: category.movies[index]);
                        },
                      )
                    : SizedBox(
                        height: 220.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: category.movies.length,
                          separatorBuilder: (_, __) => SizedBox(width: 10.w),
                          itemBuilder: (context, movieIndex) {
                            return MoviesCard(
                              movie: category.movies[movieIndex],
                              width: 150.w,
                              height: 220.h,
                            );
                          },
                        ),
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
