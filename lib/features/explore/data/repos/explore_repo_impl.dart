import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/features/explore/data/data_sources/explore_remote_data_source.dart';
import 'package:movie_app/features/explore/data/models/explore_movie_model.dart';
import 'package:movie_app/features/explore/data/repos/explore_repo.dart';

class ExploreRepoImpl implements ExploreRepo {
  final ExploreRemoteDataSource _remoteDataSource;

  ExploreRepoImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<ExploreMovieModel>>> getMoviesByGenre(
    String genre,
    int page,
  ) {
    return _remoteDataSource.getMoviesByGenre(genre, page);
  }
}
