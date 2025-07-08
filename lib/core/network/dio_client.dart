import 'dart:developer';

import 'package:dio/dio.dart';

class DioClient {
  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8000/api/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Logging interceptor
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
      ),
    );

    // Custom error handling interceptor (optional)
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          log('Dio Error: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  static final DioClient _instance = DioClient._internal();
  late Dio dio;
}
