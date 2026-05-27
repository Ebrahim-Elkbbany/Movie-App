import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/features/home/data/data_sources/movies_remote_data_source.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/data/repos/movies_repo.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remoteDataSource;

  MoviesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<MovieModel>>> getMovies() {
    return remoteDataSource.getMovies();
  }
  
  @override
  Future<Either<Failure, List<MovieModel>>> getMoviesByGenre({required String genre}) {
   return remoteDataSource.getMoviesByGenre(genre: genre);
  }
}