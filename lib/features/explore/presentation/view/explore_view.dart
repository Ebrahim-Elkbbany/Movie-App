import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/core/utils/constants/app_constants.dart';
import 'package:movie_app/features/explore/presentation/manager/explore_cubit.dart';
import 'package:movie_app/features/explore/presentation/view/widgets/explore_results_view.dart';
import 'package:movie_app/features/explore/presentation/view/widgets/genre_selector.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  late final ScrollController _scrollController;
  late final ExploreCubit _exploreCubit;

  @override
  void initState() {
    super.initState();
    _exploreCubit = getIt<ExploreCubit>()
      ..getMoviesByGenre(AppConstants.movieGenres[0]);
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.7) {
      _exploreCubit.loadMoreMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _exploreCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _exploreCubit,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                20.verticalSpace,
                GenreSelector(
                  genres: AppConstants.movieGenres,
                  onGenreChanged: (int index) {
                    _exploreCubit
                        .getMoviesByGenre(AppConstants.movieGenres[index]);
                  },
                ),
                20.verticalSpace,
                Expanded(
                  child: ExploreResultsView(
                    scrollController: _scrollController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
