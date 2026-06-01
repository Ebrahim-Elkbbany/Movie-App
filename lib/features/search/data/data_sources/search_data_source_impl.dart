import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/core/network/api_end_points.dart';
import 'package:movie_app/core/network/api_service.dart';
import 'package:movie_app/features/search/data/data_sources/search_data_source.dart';
import 'package:movie_app/features/home/data/models/response_model.dart';

class SearchDataSourceImpl implements SearchDataSource {
  final ApiService apiService;

  SearchDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, MoviesResponse>> searchMovies({
    required String query,
    required int page,
  }) async {
    try {
      final response = await apiService.get(
        urlEndPoint: ApisEndpoints.listMovies,
        queryParameters: {
          'query_term': query,
          'page': page,
          'limit': 20,
        },
      );

      return response.fold(
        (failure) => Left(failure),
        (data) {
          final movies = MoviesResponse.fromJson(data);
          return Right(movies);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
