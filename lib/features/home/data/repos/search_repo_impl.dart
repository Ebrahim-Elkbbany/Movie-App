import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/features/home/data/data_sources/search_data_source.dart';
import 'package:movie_app/features/home/data/models/response_model.dart';
import 'package:movie_app/features/home/data/repos/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchDataSource searchDataSource;

  SearchRepoImpl({required this.searchDataSource});

  @override
  Future<Either<Failure, MoviesResponse>> searchMovies({
    required int page,
    required String query,
  }) async {
    return await searchDataSource.searchMovies(page: page, query: query);
  }
}