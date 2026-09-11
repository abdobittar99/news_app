import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/mixins/safe_notifi_mixin.dart';
import 'package:news_app/feathures/home/models/news_article_model.dart';
import 'package:news_app/core/repository/news_repository.dart';

class HomeController extends ChangeNotifier with SafeNotify {
  HomeController(this.newsRepository) {
    getTopHeadline();
    getEverything();
  }

  RequestStatusEnums topHeadlineStatus = RequestStatusEnums.loading;
  RequestStatusEnums everythingStatus = RequestStatusEnums.loading;

  List<NewsArticleModel> newsTopHeadlineList = [];
  List<NewsArticleModel> newsEveryThingList = [];
  ApiService apiService = ApiService();
  String? errorMessage;
  String? selectedCategory;
  final BaseNewsRepository newsRepository;

  void getTopHeadline({String? category}) async {
    try {
      topHeadlineStatus = RequestStatusEnums.loading;
      safeNotify();

      newsTopHeadlineList = await newsRepository.getTopHeadline(
        category: category,
      );
      topHeadlineStatus = RequestStatusEnums.loaded;
      errorMessage = null;
    } catch (e) {
      topHeadlineStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  void getEverything() async {
    try {
      newsEveryThingList = await newsRepository.getEverything();
      everythingStatus = RequestStatusEnums.loaded;

      errorMessage = null;
    } catch (e) {
      everythingStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  void updateSelectedCategory({required String category}) {
    selectedCategory = category;

    getTopHeadline(category: selectedCategory);
    safeNotify();
  }
}
