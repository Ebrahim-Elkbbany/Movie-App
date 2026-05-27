import 'package:movie_app/features/home/data/models/movie_category_model.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

import 'package:equatable/equatable.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {
  const MoviesInitial();
}

class MoviesLoading extends MoviesState {
  const MoviesLoading();
}

class MoviesLoaded extends MoviesState {
  final List<MovieModel> movies;
  final int currentIndex;
final List<MovieCategoryModel> categories;
  final int currentCategoryIndex;
  const MoviesLoaded({
    required this.movies,
    this.currentIndex = 0,
    required this.categories,
    this.currentCategoryIndex = 0,
  });
 
  @override
  List<Object?> get props => [movies, currentIndex, categories, currentCategoryIndex];
}

class MoviesError extends MoviesState {
  final String message;

  const MoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
