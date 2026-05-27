import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<MovieModel>>> getMovies();
  Future<Either<Failure, List<MovieModel>>> getMoviesByGenre({ required String genre});

}