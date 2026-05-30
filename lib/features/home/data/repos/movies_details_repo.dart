import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/features/home/data/models/movie_details.dart';

abstract class MoviesDetailsRepository{
  Future<Either<Failure, MovieDetailModel>> getMoviesDetails({
      required int id,
      });
}