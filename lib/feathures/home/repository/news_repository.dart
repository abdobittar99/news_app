import 'dart:async';

import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/feathures/home/models/news_articale_model.dart';

abstract class BaseNewsRepository {
  Future<List<NewsArticaleModel>> getTopHeadline({
    String? category = "general",
  });
  Future<List<NewsArticaleModel>> getEverything();
}

class NewsRepository extends BaseNewsRepository {
  NewsRepository(this.apiService);

  final BasApiService apiService;
  @override
  Future<List<NewsArticaleModel>> getTopHeadline({
    String? category = "general",
  }) async {
    Map<String, dynamic> result = await apiService.get(
      endpoint: ApiConfig.topHeadLines,
      params: {"country": "us", "category": category},
    );

    return (result["articles"] as List)
        .map((e) => NewsArticaleModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<NewsArticaleModel>> getEverything() async {
    Map<String, dynamic> result = await apiService.get(
      endpoint: ApiConfig.everything,
      params: {"q": "sports"},
    );
    return (result["articles"] as List)
        .map((e) => NewsArticaleModel.fromJson(e))
        .toList();
  }
}
