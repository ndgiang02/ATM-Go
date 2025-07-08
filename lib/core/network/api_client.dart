import 'package:atmgo/core/network/dio_client.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = DioClient().dio;

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(path, queryParameters: queryParams);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return await _dio.delete(path, queryParameters: queryParams);
    } catch (e) {
      rethrow;
    }
  }
}
