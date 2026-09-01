import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/mixins/safe_notifi_mixin.dart';
import 'package:news_app/core/repository/news_repository.dart';
import 'package:news_app/feathures/home/models/news_articale_model.dart';

class SearchScreenController extends ChangeNotifier with SafeNotifi {
  SearchScreenController(this.newsRepository);
  RequestStatusEnums everythingStatus = RequestStatusEnums.loading;
  List<NewsArticaleModel> newsEveryThingList = [];
  String? errorMessage;
  final BaseNewsRepository newsRepository;

  TextEditingController searchController = TextEditingController();

  void getEverything() async {
    try {
      newsEveryThingList = await newsRepository.getEverything(
        query: searchController.text,
      );
      everythingStatus = RequestStatusEnums.loaded;

      errorMessage = null;
    } catch (e) {
      everythingStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    safeNotifi();
  }
}
