import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/explore/data/models/explore_movie_model.dart';
import 'package:movie_app/features/explore/data/repos/explore_repo.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepo _exploreRepo;

  ExploreCubit(this._exploreRepo) : super(ExploreInitial());

  String _currentGenre = 'Action';
  int _currentPage = 1;

  String get currentGenre => _currentGenre;

  Future<void> getMoviesByGenre(String genre) async {
    _currentGenre = genre;
    _currentPage = 1;
    emit(ExploreLoading());

    final result = await _exploreRepo.getMoviesByGenre(genre, _currentPage);

    result.fold(
      (failure) => emit(ExploreFailure(failure.errorMessage)),
      (movies) {
        emit(ExploreSuccess(
          movies: movies,
          page: _currentPage,
          hasReachedMax: movies.isEmpty,
        ));
      },
    );
  }

  Future<void> loadMoreMovies() async {
    final ExploreState currentState = state;

    if (currentState is ExploreSuccess && !currentState.hasReachedMax) {
      final List<ExploreMovieModel> oldMovies = currentState.movies;
      emit(ExplorePaginationLoading(oldMovies));

      _currentPage++;
      final result =
          await _exploreRepo.getMoviesByGenre(_currentGenre, _currentPage);

      result.fold(
        (failure) {
          _currentPage--;
          emit(ExploreSuccess(
            movies: oldMovies,
            page: _currentPage,
            hasReachedMax: false,
          ));
        },
        (newMovies) {
          if (newMovies.isEmpty) {
            emit(ExploreSuccess(
              movies: oldMovies,
              page: _currentPage - 1,
              hasReachedMax: true,
            ));
          } else {
            emit(ExploreSuccess(
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
