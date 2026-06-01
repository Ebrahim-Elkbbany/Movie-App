import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/core/network/api_end_points.dart';
import 'package:movie_app/core/network/api_service.dart';
import 'package:movie_app/features/explore/data/data_sources/explore_remote_data_source.dart';
import 'package:movie_app/features/explore/data/models/explore_movie_model.dart';
import 'package:movie_app/features/explore/data/models/explore_movies_model.dart';

class ExploreRemoteDataSourceImpl implements ExploreRemoteDataSource {
  final ApiService _apiService;

  ExploreRemoteDataSourceImpl(this._apiService);

  @override
  Future<Either<Failure, List<ExploreMovieModel>>> getMoviesByGenre(
    String genre,
    int page,
  ) async {
    try {
      final response = await _apiService.get(
        urlEndPoint: ApisEndpoints.listMovies,
        queryParameters: {'genre': genre, 'page': page, 'limit': 20},
      );

      return response.fold(
        (failure) => Left(failure),
        (data) {
          final ExploreMoviesModel moviesModel =
              ExploreMoviesModel.fromJson(data);
          final List<ExploreMovieModel> movies =
              moviesModel.data?.movies ?? [];
          return Right(movies);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
