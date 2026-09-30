import 'package:dio/dio.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_config.dart';
import 'package:news_app/core/datasource/remote_data/interceptors/auth_interceptor.dart';
import 'package:news_app/core/datasource/remote_data/interceptors/logging_interceptor.dart';

class AuthDioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 30),
        baseUrl: AuthApiConfig.authBaseUrl,
        headers: {"Content-Type": "application/json"},
      ),
    );
    dio.interceptors.addAll([LoggingInterceptor(), AuthInterceptor()]);
    return dio;
  }
}
