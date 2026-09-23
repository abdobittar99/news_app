import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/repository/news_repository.dart';
import 'package:news_app/feathures/home/models/news_article_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.newsRepository) : super(const SearchState());

  final BaseNewsRepository newsRepository;

  TextEditingController searchController = TextEditingController();

  void getEverything() async {
    try {
      emit(
        state.copyWith(
          newsEveryThingList: await newsRepository.getEverything(
            query: searchController.text,
          ),
          everythingStatus: RequestStatusEnums.loaded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          everythingStatus: RequestStatusEnums.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
