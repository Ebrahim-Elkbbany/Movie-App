import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/models/movie_category_model.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/data/repos/movies_repo.dart';
import 'package:movie_app/features/home/presentation/manager/movies_states.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this.moviesRepository) : super(const MoviesInitial());

  final MoviesRepository moviesRepository;

  Future<void> fetchMovies() async {
    emit(const MoviesLoading());

    final featuredResult = await moviesRepository.getMovies();

    featuredResult.fold((failure) => emit(MoviesError(failure.errorMessage)), (
      movies,
    ) async {
      final sortedMovies = List<MovieModel>.from(movies)
        ..sort((a, b) => b.year.compareTo(a.year));

      final genres = ['Action', 'Drama', 'Thriller', 'Comedy'];

      List<MovieCategoryModel> categories = [];

      for (final genre in genres) {
        final result = await moviesRepository.getMoviesByGenre(genre: genre);

        result.fold((failure) {}, (movies) {
          categories.add(MovieCategoryModel(title: genre, movies: movies));
        });
      }

      emit(
        MoviesLoaded(
          movies: sortedMovies,
          categories: categories,
          currentIndex: 0,
          currentCategoryIndex: 0,
        ),
      );
    });
  }

  void changeIndex(int index) {
    final currentState = state;

    if (currentState is MoviesLoaded) {
      emit(
        MoviesLoaded(
          movies: currentState.movies,
          categories: currentState.categories,
          currentIndex: index,
          currentCategoryIndex: currentState.currentCategoryIndex,
        ),
      );
    }
  }

  void changeCategoryIndex(int index) {
    final currentState = state;

    if (currentState is MoviesLoaded) {
      emit(
        MoviesLoaded(
          movies: currentState.movies,
          categories: currentState.categories,
          currentIndex: currentState.currentIndex,
          currentCategoryIndex: index,
        ),
      );
    }
  }
}
