import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/navigation/app_routes.dart';
import 'package:movie_app/core/widgets/custom_app_bar.dart';
import 'package:movie_app/core/widgets/feedback/custom_error_widget.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/presentation/manager/category_movies_cubit.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/movie_card.dart';

class CategoryMoviesView extends StatefulWidget {
  const CategoryMoviesView({super.key, required this.genre});

  final String genre;

  @override
  State<CategoryMoviesView> createState() => _CategoryMoviesViewState();
}

class _CategoryMoviesViewState extends State<CategoryMoviesView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      context.read<CategoryMoviesCubit>().loadMoreMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.genre,
      ),
      body: BlocBuilder<CategoryMoviesCubit, CategoryMoviesState>(
        builder: (context, state) {
          if (state is CategoryMoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryMoviesFailure) {
            return Center(child: CustomErrorWidget(errorMessage: state.errorMessage));
          } else if (state is CategoryMoviesSuccess || state is CategoryPaginationLoading) {
            List<MovieModel> movies = [];
            bool isLoadingMore = false;

            if (state is CategoryMoviesSuccess) {
              movies = state.movies;
            } else if (state is CategoryPaginationLoading) {
              movies = state.oldMovies;
              isLoadingMore = true;
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      itemCount: movies.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                      ),
                      itemBuilder: (context, index) {
                        return MoviesCard(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.detailsView,
                              arguments: movies[index].id,
                            );
                          },
                          movie: movies[index],
                        );
                      },
                    ),
                  ),
                  if (isLoadingMore)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const CircularProgressIndicator(),
                    ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
