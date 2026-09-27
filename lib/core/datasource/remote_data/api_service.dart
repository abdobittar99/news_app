import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';

abstract class BasApiService {
  Future<dynamic> get({
    required String endpoint,
    required String baseUrl,
    Map<String, dynamic>? params,
  });
  Future<dynamic> getWithToken({
    required String endpoint,
    required String baseUrl,
    String? token,
  });
  Future<dynamic> post({
    required String endpoint,
    required String baseUrl,
    Map<String, dynamic>? body,
  });
}

class ApiService extends BasApiService {
  @override
  Future<dynamic> get({
    required String endpoint,
    required String baseUrl,
    Map<String, dynamic>? params,
  }) async {
    var url = Uri.http(baseUrl, "v2/$endpoint", {
      "apiKey": ApiConfig.apikey,
      ...?params,
    });

    try {
      final http.Response response = await http.get(url);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception("Failed to load data");
    }
  }

  @override
  Future<dynamic> post({
    required String endpoint,
    required String baseUrl,
    Map<String, dynamic>? body,
  }) async {
    var url = Uri.https(baseUrl, endpoint);
    final headers = {"Content-Type": "application/json"};
    final token = UserRepository().getUser()?.accessToken;

    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }
    try {
      final http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      final responsebody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responsebody;
      } else {
        throw (responsebody["message"] ?? "Failed to post data");
      }
    } catch (e) {
      throw ("Failed to post data");
    }
  }

  @override
  Future<dynamic> getWithToken({
    required String endpoint,
    required String baseUrl,
    String? token,
  }) async {
    var url = Uri.https(baseUrl, endpoint);

    try {
      final headers = {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      };
      final http.Response response = await http.get(url, headers: headers);
      final responsebody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responsebody;
      } else {
        throw Exception(responsebody["message"] ?? "Failed to post data");
      }
    } catch (e) {
      throw Exception("Failed to post data");
    }
  }
}
