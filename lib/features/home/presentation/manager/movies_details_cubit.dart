import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/repos/movies_details_repo.dart';
import 'package:movie_app/features/home/presentation/manager/movies_details_state.dart';

class MoviesDetailsCubit extends Cubit<MoviesDetailsState> {
  MoviesDetailsCubit(this.moviesDetailsRepository)
    : super(const MoviesDetailsInitialState());

  final MoviesDetailsRepository moviesDetailsRepository;
  Future<void> fetchMoviesDetails({required int id}) async {
    emit(const MoviesDetailsLoadingState());

    final result = await moviesDetailsRepository.getMoviesDetails(id: id);

    result.fold(
      (failure) => emit(MoviesDetailsErrorState(message: failure.errorMessage)),
      (movieDetails) =>
          emit(MoviesDetailsLoadedState(movieDetails: movieDetails)),
    );
  }
}
