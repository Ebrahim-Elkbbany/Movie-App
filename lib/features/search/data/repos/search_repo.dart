import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/features/home/data/models/response_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, MoviesResponse>> searchMovies({
    required int page,
    required String query,
  });

  
}
