import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failures.dart';

abstract class UseCase<T> {
  Future<Either<Failure, T>> call();
}
