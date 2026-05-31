import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/models/movie_details.dart';
import 'package:movie_app/features/profile/data/repos/profile_repo.dart';
import 'package:movie_app/features/profile/presentation/manager/watchlist_cubit/watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final ProfileRepo _profileRepo;

  WatchlistCubit(this._profileRepo) : super(WatchlistInitial());

  bool _isInWatchlist = false;
  bool _isInHistory = false;

  bool get isInWatchlist => _isInWatchlist;
  bool get isInHistory => _isInHistory;

  Future<void> checkStatus(int movieId) async {
    emit(WatchlistLoading());
    final movieIdStr = movieId.toString();

    final watchlistResult = await _profileRepo.isInWatchlist(movieIdStr);
    final historyResult = await _profileRepo.isInHistory(movieIdStr);

    watchlistResult.fold(
      (_) => _isInWatchlist = false,
      (value) => _isInWatchlist = value,
    );
    historyResult.fold(
      (_) => _isInHistory = false,
      (value) => _isInHistory = value,
    );

    emit(WatchlistStatusLoaded(
      isInWatchlist: _isInWatchlist,
      isInHistory: _isInHistory,
    ));
  }

  Future<void> toggleWatchlist(MovieDetailModel movie) async {
    if (_isInWatchlist) {
      final result =
          await _profileRepo.removeFromWatchlist(movie.id.toString());
      result.fold(
        (failure) => emit(WatchlistError(failure.errorMessage)),
        (_) {
          _isInWatchlist = false;
          emit(WatchlistStatusLoaded(
            isInWatchlist: _isInWatchlist,
            isInHistory: _isInHistory,
          ));
          emit(WatchlistActionSuccess('Removed from Watchlist'));
        },
      );
    } else {
      final result = await _profileRepo.addToWatchlist(movie.toFirestoreMap());
      result.fold(
        (failure) => emit(WatchlistError(failure.errorMessage)),
        (_) {
          _isInWatchlist = true;
          emit(WatchlistStatusLoaded(
            isInWatchlist: _isInWatchlist,
            isInHistory: _isInHistory,
          ));
          emit(WatchlistActionSuccess('Added to Watchlist'));
        },
      );
    }
  }

  Future<void> addToHistory(MovieDetailModel movie) async {
    if (_isInHistory) return; // already in history
    final result = await _profileRepo.addToHistory(movie.toFirestoreMap());
    result.fold(
      (failure) => emit(WatchlistError(failure.errorMessage)),
      (_) {
        _isInHistory = true;
        emit(WatchlistStatusLoaded(
          isInWatchlist: _isInWatchlist,
          isInHistory: _isInHistory,
        ));
        emit(WatchlistActionSuccess('Added to History'));
      },
    );
  }
}
