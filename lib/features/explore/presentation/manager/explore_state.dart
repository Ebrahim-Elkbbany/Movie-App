part of 'explore_cubit.dart';

abstract class ExploreState {
  final List<ExploreMovieModel> movies;
  const ExploreState({this.movies = const []});
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreSuccess extends ExploreState {
  final int page;
  final bool hasReachedMax;

  const ExploreSuccess({
    required super.movies,
    required this.page,
    this.hasReachedMax = false,
  });
}

class ExplorePaginationLoading extends ExploreState {
  const ExplorePaginationLoading(List<ExploreMovieModel> movies)
      : super(movies: movies);
}

class ExploreFailure extends ExploreState {
  final String errorMessage;

  const ExploreFailure(this.errorMessage);
}
