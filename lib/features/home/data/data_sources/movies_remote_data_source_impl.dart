import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/core/network/api_end_points.dart';
import 'package:movie_app/core/network/api_service.dart';
import 'package:movie_app/features/home/data/data_sources/movies_remote_data_source.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final ApiService apiService;

  MoviesRemoteDataSourceImpl(this.apiService);
  @override
 Future<Either<Failure, List<MovieModel>>> getMovies() async {
  try {
    final response = await apiService.get(
      urlEndPoint: ApisEndpoints.listMovies,
    );

    return response.fold(
      (failure) => Left(failure),
      (data) {
        final movies = (data['data']['movies'] as List)
            .map((movie) => MovieModel.fromJson(movie))
            .toList();

        return Right(movies);
      },
    );
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

@override
Future<Either<Failure, List<MovieModel>>> getMoviesByGenre({required String genre, int page = 1}) async {
  try {
    final response = await apiService.get(
      urlEndPoint: ApisEndpoints.listMovies,
      queryParameters: {'genre': genre, 'page': page},
    );

    return response.fold(
      (failure) => Left(failure),
      (data) {
        final movies = (data['data']['movies'] as List)
            .map((movie) => MovieModel.fromJson(movie))
            .toList();

        return Right(movies);
      },
    );
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}
}
