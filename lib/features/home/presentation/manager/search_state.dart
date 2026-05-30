import 'package:equatable/equatable.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

 class SearchInitial extends SearchState {}

 class SearchLoading extends SearchState {}

 class SearchSuccess extends SearchState {
  final List<MovieModel> movies;
  final bool hasMore;

  const SearchSuccess({
    required this.movies,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [movies, hasMore];
}

 class SearchPaginationLoading extends SearchState {
  final List<MovieModel> oldMovies;

  const SearchPaginationLoading(this.oldMovies);

  @override
  List<Object?> get props => [oldMovies];
}

 class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}