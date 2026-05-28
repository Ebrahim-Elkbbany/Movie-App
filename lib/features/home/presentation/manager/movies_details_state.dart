import 'package:movie_app/features/home/data/models/movie_details.dart';

sealed class MoviesDetailsState {
  const MoviesDetailsState();
}

class MoviesDetailsInitialState extends MoviesDetailsState {
  const MoviesDetailsInitialState();
}

class MoviesDetailsLoadingState extends MoviesDetailsState {
  const MoviesDetailsLoadingState();
}

class MoviesDetailsLoadedState extends MoviesDetailsState {
  final MovieDetailModel movieDetails;
  const MoviesDetailsLoadedState({required this.movieDetails});
}
  class MoviesDetailsErrorState extends MoviesDetailsState {
  final String message;   
  const MoviesDetailsErrorState({required this.message});
}