import 'dart:developer';

import 'package:ansicolor/ansicolor.dart';
import 'package:dartz/dartz.dart'; // تأكدي من إضافة مكتبة dartz في pubspec.yaml
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/core/failure/failures.dart';
import 'package:movie_app/core/network/api_end_points.dart';
import 'package:movie_app/core/network/tocken_storage_service.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

///how to use it in repository
/// Future<Either<Failure, YourModel>> getSomething() async {
///  // 1. Call the API (no try-catch needed here anymore!)
///  final result = await _apiService.get(urlEndPoint: "your/endpoint");
///
///  // 2. Handle the Either result
///   return result.fold(
///   (failure) => Left(failure), // If it's a failure, just pass it up
///    (data) => Right(YourModel.fromJson(data)), // If success, parse the data
///  );
///}

class ApiService {
  late Dio dio;
  final tokenService = TokenStorageService();

  String get _baseUrlFromEnv => ApisEndpoints.baseUrl;

  ApiService._();

  static Future<ApiService> create() async {
    final instance = ApiService._();
    await instance._initialize();
    return instance;
  }

  Future<void> _initialize() async {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrlFromEnv,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Interceptor للتعامل مع التوكن والـ 401
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final savedToken = await tokenService.getToken();
          if (savedToken != null &&
              savedToken.isNotEmpty &&
              savedToken != 'none') {
            options.headers['Authorization'] = 'Bearer $savedToken';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            log('Token is invalid or expired. Cleaning up...');
            await tokenService.deleteToken();
          }
          return handler.next(e);
        },
      ),
    );

    // Logger للـ Debugging
    if (kDebugMode) {
      dio.interceptors.add(
        TalkerDioLogger(
          settings: TalkerDioLoggerSettings(
            enabled: true,
            printResponseHeaders: true,
            printRequestHeaders: true,
            printResponseTime: true,
            printResponseRedirects: true,
            requestPen: AnsiPen()..white(),
            responsePen: AnsiPen()..green(),
            errorPen: AnsiPen()..red(),
          ),
        ),
      );
    }
  }

  // --- [Centralized Safe API Call Helper] ---

  /// دالة مركزية تقوم بتنفيذ أي طلب API وتغليفه بـ try/catch
  /// لترجع Either (إما Failure أو البيانات الناجحة)
  Future<Either<Failure, dynamic>> _safeApiCall(
    Future<Response> Function() call,
  ) async {
    try {
      final response = await call();
      return Right(response.data);
    } on DioException catch (e) {
      // تحويل خطأ Dio لـ ServerFailure الخاص بك
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      // أي خطأ غير متوقع آخر
      return Left(ServerFailure(e.toString()));
    }
  }

  // --- [العمليات الأساسية المحدثة] ---

  Future<Either<Failure, dynamic>> get({
    required String urlEndPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _safeApiCall(
      () => dio.get(urlEndPoint, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> post({
    required String urlEndPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _safeApiCall(
      () => dio.post(urlEndPoint, data: data, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> put({
    required String urlEndPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _safeApiCall(
      () => dio.put(urlEndPoint, data: data, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> delete({
    required String urlEndPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _safeApiCall(
      () =>
          dio.delete(urlEndPoint, data: data, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> patch({
    required String urlEndPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _safeApiCall(
      () =>
          dio.patch(urlEndPoint, data: data, queryParameters: queryParameters),
    );
  }
}
