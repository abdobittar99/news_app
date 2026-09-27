part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.everythingStatus = RequestStatus.loading,
    this.topHeadlineStatus = RequestStatus.loading,
    this.errorMessage,
    this.selectedCategory,
    this.newsTopHeadLineList = const [],
    this.newsEverythingList = const [],
  });

  final RequestStatus everythingStatus;
  final RequestStatus topHeadlineStatus;

  final String? errorMessage;

  final String? selectedCategory;

  final List<NewsArticleModel> newsTopHeadLineList;
  final List<NewsArticleModel> newsEverythingList;

  HomeState copyWith({
    RequestStatus? everythingStatus,
    RequestStatus? topHeadlineStatus,
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
