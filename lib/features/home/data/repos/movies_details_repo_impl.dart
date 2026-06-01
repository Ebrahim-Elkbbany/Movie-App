import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/features/home/data/data_sources/movies_details_data_source.dart';
import 'package:movie_app/features/home/data/models/movie_details.dart';
import 'package:movie_app/features/home/data/repos/movies_details_repo.dart';

class MoviesDetailsRepositoryImpl implements MoviesDetailsRepository {
  final MoviesDetailsDataSource dataSource;

  MoviesDetailsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, MovieDetailModel>> getMoviesDetails({
    required int id,
  }) {
    return dataSource.getMoviesDetails(id: id);
  }
} 
