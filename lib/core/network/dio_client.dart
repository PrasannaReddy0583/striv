import 'package:dio/dio.dart';

class DioClient {
  static const String _baseUrl = 'http://localhost:3000/api';

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.next(options),
        onResponse: (response, handler) => handler.next(response),
        onError: (DioException error, handler) => handler.next(error),
      ),
    );

    return dio;
  }
}
