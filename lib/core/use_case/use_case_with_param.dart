import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';

abstract class UseCaseWithParam<T, Param> {
  Future<Either<Failure, T>> call({required Param param});
}
