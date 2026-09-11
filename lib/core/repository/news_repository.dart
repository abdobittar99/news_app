import 'dart:async';

import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/feathures/home/models/news_article_model.dart';

abstract class BaseNewsRepository {
  Future<List<NewsArticleModel>> getTopHeadline({String? category = "general"});
  Future<List<NewsArticleModel>> getEverything({String? query = "news"});
}

class NewsRepository extends BaseNewsRepository {
  NewsRepository(this.apiService);

  final BasApiService apiService;
  @override
  Future<List<NewsArticleModel>> getTopHeadline({
    String? category = "general",
  }) async {
    Map<String, dynamic> result = await apiService.get(
      endpoint: ApiConfig.topHeadLines,
      params: {"country": "us", "category": category},
    );

    return (result["articles"] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<NewsArticleModel>> getEverything({String? query = "news"}) async {
    Map<String, dynamic> result = await apiService.get(
      endpoint: ApiConfig.everything,
      params: {"q": query},
    );
    return (result["articles"] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }
}
