import 'package:dio/dio.dart';
import 'package:news_app/core/datasource/remote_data/interceptors/api_key_interceptor.dart';
import 'package:news_app/core/datasource/remote_data/interceptors/logging_interceptor.dart';
import 'package:news_app/core/datasource/remote_data/news/news_api_config.dart';

class NewsDioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 30),
        baseUrl: NewsApiConfig.newsBaseUrl,
        headers: {"Content-Type": "application/json"},
      ),
    );
    dio.interceptors.addAll([ApiKeyInterceptor(), LoggingInterceptor()]);
    return dio;
  }
}
