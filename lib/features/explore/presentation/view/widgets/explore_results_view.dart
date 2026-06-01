import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/navigation/app_routes.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/core/widgets/feedback/custom_error_widget.dart';
import 'package:movie_app/features/explore/data/models/explore_movie_model.dart';
import 'package:movie_app/features/explore/presentation/manager/explore_cubit.dart';
import 'package:movie_app/features/explore/presentation/view/widgets/explore_movie_card.dart';

class ExploreResultsView extends StatelessWidget {
  final ScrollController scrollController;

  const ExploreResultsView({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        if (state is ExploreLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ExploreFailure) {
          return CustomErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () => context.read<ExploreCubit>().getMoviesByGenre(
                  context.read<ExploreCubit>().currentGenre,
                ),
          );
        }

        if (state is ExploreInitial) {
          return Center(
            child: Text(
              'Select a genre to explore',
              style: context.textTheme.bodyLarge,
            ),
          );
        }

        if (state.movies.isEmpty) {
          return Center(
            child: Text(
              'No movies found for this genre',
              style: context.textTheme.bodyLarge,
            ),
          );
        }

        final bool isPaginationLoading = state is ExplorePaginationLoading;

        return GridView.builder(
          controller: scrollController,
          padding: REdgeInsets.only(bottom: 80),
          itemCount: state.movies.length + (isPaginationLoading ? 1 : 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
          ),
          itemBuilder: (context, index) {
            if (index < state.movies.length) {
              final ExploreMovieModel movie = state.movies[index];
              return ExploreMovieCard(
                imageUrl: movie.mediumCoverImage ?? '',
                rating: movie.rating ?? 0.0,
                onTap: () {
                  if (movie.id == null) return;
                  Navigator.pushNamed(
                    context,
                    AppRoutes.detailsView,
                    arguments: movie.id,
                  );
                },
              );
            }
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      },
    );
  }
}
