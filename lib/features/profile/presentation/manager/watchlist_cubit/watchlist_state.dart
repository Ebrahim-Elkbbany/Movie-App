abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistStatusLoaded extends WatchlistState {
  final bool isInWatchlist;
  final bool isInHistory;

  WatchlistStatusLoaded({
    required this.isInWatchlist,
    required this.isInHistory,
  });
}

class WatchlistActionSuccess extends WatchlistState {
  final String message;
  WatchlistActionSuccess(this.message);
}

class WatchlistError extends WatchlistState {
  final String message;
  WatchlistError(this.message);
}
