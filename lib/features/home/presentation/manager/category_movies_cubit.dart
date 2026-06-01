import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/data/repos/movies_repo.dart';

part 'category_movies_state.dart';

class CategoryMoviesCubit extends Cubit<CategoryMoviesState> {
  final MoviesRepository _moviesRepo;

  CategoryMoviesCubit(this._moviesRepo) : super(CategoryMoviesInitial());

  String _currentGenre = '';
  int _currentPage = 1;

  String get currentGenre => _currentGenre;

  Future<void> getMoviesByGenre(String genre) async {
    _currentGenre = genre;
    _currentPage = 1;
    emit(CategoryMoviesLoading());

    final result = await _moviesRepo.getMoviesByGenre(genre: genre, page: _currentPage);

    result.fold(
      (failure) => emit(CategoryMoviesFailure(failure.errorMessage)),
      (movies) {
        emit(CategoryMoviesSuccess(
          movies: movies,
          page: _currentPage,
          hasReachedMax: movies.isEmpty,
        ));
      },
    );
  }

  Future<void> loadMoreMovies() async {
    final CategoryMoviesState currentState = state;

    if (currentState is CategoryMoviesSuccess && !currentState.hasReachedMax) {
      final List<MovieModel> oldMovies = currentState.movies;
      emit(CategoryPaginationLoading(oldMovies));

      _currentPage++;
      final result = await _moviesRepo.getMoviesByGenre(genre: _currentGenre, page: _currentPage);

      result.fold(
        (failure) {
          _currentPage--;
          emit(CategoryMoviesSuccess(
            movies: oldMovies,
            page: _currentPage,
            hasReachedMax: false,
          ));
        },
        (newMovies) {
          if (newMovies.isEmpty) {
            emit(CategoryMoviesSuccess(
              movies: oldMovies,
              page: _currentPage - 1,
              hasReachedMax: true,
            ));
          } else {
            emit(CategoryMoviesSuccess(
              movies: oldMovies + newMovies,
              page: _currentPage,
              hasReachedMax: false,
            ));
          }
        },
      );
    }
  }
}
