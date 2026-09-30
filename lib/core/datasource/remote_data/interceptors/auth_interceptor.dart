import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/feathures/auth/login_screen.dart';
import 'package:news_app/main.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = UserRepository().getUser()?.accessToken;

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      final BuildContext context = navigatorKey.currentContext!;
      UserRepository().delete();
      PreferencesManeger().clear();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Session Expire please login again")),
      );
    }
    handler.next(err);
  }
}
