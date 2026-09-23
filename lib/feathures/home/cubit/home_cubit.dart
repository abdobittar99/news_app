import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/repository/news_repository.dart';
import 'package:news_app/feathures/home/models/news_article_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.newsRepository) : super(HomeState()) {
    getTopHeadline();
    getEverything();
  }
  final BaseNewsRepository newsRepository;
  void getTopHeadline({String? category}) async {
    try {
      emit(state.copyWith(topHeadlineStatus: RequestStatusEnums.loading));

      final artical = await newsRepository.getTopHeadline(category: category);
      emit(
        state.copyWith(
          newsTopHeadLineList: artical,
          topHeadlineStatus: RequestStatusEnums.loaded,

          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          topHeadlineStatus: RequestStatusEnums.error,
        ),
      );
    }
  }

  void getEverything() async {
    try {
      final artical = await newsRepository.getEverything();
      emit(
        state.copyWith(
          newsEverythingList: artical,
          everythingStatus: RequestStatusEnums.loaded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          everythingStatus: RequestStatusEnums.error,
        ),
      );
     
    }
  }

  void updateSelectedCategory({required String category}) {
    emit(state.copyWith(selectedCategory: category));

    getTopHeadline(category: state.selectedCategory);
  }
}
