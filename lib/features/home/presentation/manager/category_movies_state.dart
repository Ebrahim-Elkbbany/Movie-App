part of 'category_movies_cubit.dart';

abstract class CategoryMoviesState {}

class CategoryMoviesInitial extends CategoryMoviesState {}

class CategoryMoviesLoading extends CategoryMoviesState {}

class CategoryMoviesSuccess extends CategoryMoviesState {
  final List<MovieModel> movies;
  final int page;
  final bool hasReachedMax;

  CategoryMoviesSuccess({
    required this.movies,
    required this.page,
    required this.hasReachedMax,
  });
}

class CategoryMoviesFailure extends CategoryMoviesState {
  final String errorMessage;

  CategoryMoviesFailure(this.errorMessage);
}

class CategoryPaginationLoading extends CategoryMoviesState {
  final List<MovieModel> oldMovies;

  CategoryPaginationLoading(this.oldMovies);
}
