import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/feathures/home/models/news_articale_model.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getTopHeadline();
    getEverything();
  }

  RequestStatusEnums topHeadlineStatus = RequestStatusEnums.loading;
  RequestStatusEnums everythingStatus = RequestStatusEnums.loading;

  List<NewsArticaleModel> newsTopHeadlineList = [];
  List<NewsArticaleModel> newsEveryThingList = [];
  ApiService apiService = ApiService();
  String? errorMessage;
  String? selectedCategory;

  void getTopHeadline({String? category}) async {
    try {
      topHeadlineStatus = RequestStatusEnums.loading;
      notifyListeners();
      Map<String, dynamic> result = await apiService.get(
        endpoint: ApiConfig.topHeadLines,
        params: {"country": "us", "category": category},
      );

      newsTopHeadlineList = (result["articles"] as List)
          .map((e) => NewsArticaleModel.fromJson(e))
          .toList();
      topHeadlineStatus = RequestStatusEnums.loaded;
      errorMessage = null;
    } catch (e) {
      topHeadlineStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void getEverything() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        endpoint: ApiConfig.everything,
        params: {"q": "sports"},
      );
      newsEveryThingList = (result["articles"] as List)
          .map((e) => NewsArticaleModel.fromJson(e))
          .toList();
      everythingStatus = RequestStatusEnums.loaded;
      errorMessage = null;
    } catch (e) {
      everythingStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void updateSelectedCategory({required String category}) {
    selectedCategory = category;

    getTopHeadline(category: selectedCategory);
    notifyListeners();
  }
}
