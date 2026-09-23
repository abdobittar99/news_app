part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.everythingStatus = RequestStatusEnums.loading,
    this.topHeadlineStatus = RequestStatusEnums.loading,
    this.errorMessage,
    this.selectedCategory,
    this.newsTopHeadLineList = const [],
    this.newsEverythingList = const [],
  });

  final RequestStatusEnums everythingStatus;
  final RequestStatusEnums topHeadlineStatus;

  final String? errorMessage;

  final String? selectedCategory;

  final List<NewsArticleModel> newsTopHeadLineList;
  final List<NewsArticleModel> newsEverythingList;

  HomeState copyWith({
    RequestStatusEnums? everythingStatus,
    RequestStatusEnums? topHeadlineStatus,
    String? errorMessage,
    String? selectedCategory,
    List<NewsArticleModel>? newsTopHeadLineList,
    List<NewsArticleModel>? newsEverythingList,
  }) {
    return HomeState(
      everythingStatus: everythingStatus ?? this.everythingStatus,
      topHeadlineStatus: topHeadlineStatus ?? this.topHeadlineStatus,
      errorMessage: errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      newsTopHeadLineList: newsTopHeadLineList ?? this.newsTopHeadLineList,
      newsEverythingList: newsEverythingList ?? this.newsEverythingList,
    );
  }

  @override
  List<Object?> get props => [
    everythingStatus,
    topHeadlineStatus,
    errorMessage,
    selectedCategory,
    newsTopHeadLineList,
    newsEverythingList,
  ];
}
