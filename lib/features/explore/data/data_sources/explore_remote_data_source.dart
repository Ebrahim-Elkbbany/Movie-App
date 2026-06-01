import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/features/explore/data/models/explore_movie_model.dart';

abstract class ExploreRemoteDataSource {
  Future<Either<Failure, List<ExploreMovieModel>>> getMoviesByGenre(
    String genre,
    int page,
  );
}
