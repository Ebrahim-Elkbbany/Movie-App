import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/core/network/api_end_points.dart';
import 'package:movie_app/core/network/api_service.dart';
import 'package:movie_app/features/home/data/data_sources/movies_details_data_source.dart';
import 'package:movie_app/features/home/data/models/movie_details.dart';

class MoviesDetailsDataSourceImpl implements MoviesDetailsDataSource {
  final ApiService apiService;

  MoviesDetailsDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, MovieDetailModel>> getMoviesDetails({
    required int id,
  }) async {
    try {
     final result = await apiService.get(
  urlEndPoint: ApisEndpoints.movieDetails,
  queryParameters: {
    'movie_id': id,
    'with_images': true,
    'with_cast': true,
  },
);

return result.fold(
  (failure) => Left(failure),
  (response) {
    final model = MovieDetailModel.fromJson(response);
    return Right(model);
  },
);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
