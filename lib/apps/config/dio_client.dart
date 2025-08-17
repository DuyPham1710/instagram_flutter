import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late Dio dio;
  // String? token;

  DioClient._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://192.168.100.218:3000/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    dio = Dio(options);

    // Interceptor dùng cho logging hoặc gắn token
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          //     print('✅ [Response] ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          //     print('❌ [Error] ${e.response?.statusCode} ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  void updateToken(String token) {
    // token = newToken;
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
