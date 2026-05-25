import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
 import 'package:movie_app/features/home/data/models/movie_model.dart';


abstract class MoviesRemoteDataSource {
  Future<Either<Failure, List<MovieModel>>> getMovies();
}