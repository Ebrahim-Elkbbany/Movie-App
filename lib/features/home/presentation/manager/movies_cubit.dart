import 'package:flutter_bloc/flutter_bloc.dart';
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
      (movies) => emit(MoviesLoaded(movies)),
    );
  }
}