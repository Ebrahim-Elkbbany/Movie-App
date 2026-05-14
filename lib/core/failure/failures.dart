import 'package:dio/dio.dart';
import 'package:movie_app/generated/l10n.dart';

abstract class Failure {
  final String errorMessage;
  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    final s = S.current;
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(s.connectionTimeout);
      case DioExceptionType.receiveTimeout:
        return ServerFailure(s.receiveTimeout);
      case DioExceptionType.sendTimeout:
        return ServerFailure(s.sendTimeout);
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(s.requestCancelled);
      case DioExceptionType.unknown:
        if (dioException.toString().contains('SocketException')) {
          return ServerFailure(s.noInternetConnection);
        }
        return ServerFailure(s.unexpectedError);
      default:
        return ServerFailure(s.oopsSomethingWentWrong);
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    final s = S.current;
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 422) {
      return ServerFailure(
        (response['message']) is int ? response['errors'] : response['message'],
      );
    } else if (statusCode == 404) {
      return ServerFailure(s.requestNotFound);
    } else if (statusCode == 500) {
      return ServerFailure(s.internalServerError);
    } else {
      return ServerFailure(s.oopsSomethingWentWrong);
    }
  }
}
