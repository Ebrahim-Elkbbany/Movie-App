import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/data/repos/movies_repo.dart';
import 'package:movie_app/features/home/presentation/manager/movies_states.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this.moviesRepository) : super(const MoviesInitial());

  final MoviesRepository moviesRepository;

  Future<void> fetchMovies() async {
    emit(const MoviesLoading());

    final result = await moviesRepository.getMovies();

    result.fold(
      (failure) => emit(MoviesError(failure.errorMessage)),
    (movies) {
       final sortedMovies = List<MovieModel>.from(movies)
        ..sort((a, b) => b.year.compareTo(a.year));

      emit(MoviesLoaded(movies: sortedMovies));
    },
  );
}
 
void changeIndex(int index) {
  final currentState = state;

  if (currentState is MoviesLoaded) {
    emit(
      MoviesLoaded(
        movies: currentState.movies,
        currentIndex: index,
      ),
    );
  }
}
}