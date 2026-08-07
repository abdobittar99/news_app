import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/feathures/home/models/news_articale_model.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getTopHeadline();
    getEverything();
  }

  bool topHeadlineLoading = true;
  bool everyThingLoading = true;

  List<NewsArticaleModel> newsTopHeadlineList = [];
  List<NewsArticaleModel> newsEveryThingList = [];
  ApiService apiService = ApiService();
  String? errorMessage;

  void getTopHeadline() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        endpoint: ApiConfig.topHeadLines,
        params: {"country": "us"},
      );

      newsTopHeadlineList = (result["articles"] as List)
          .map((e) => NewsArticaleModel.fromJson(e))
          .toList();
      topHeadlineLoading = false;
      errorMessage = null;
    } catch (e) {
      topHeadlineLoading = false;
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
      everyThingLoading = false;
      errorMessage = null;
    } catch (e) {
      everyThingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
