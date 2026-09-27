part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({
    this.everythingStatus = RequestStatus.loading,
    this.newsEveryThingList = const [],
    this.errorMessage,
  });
  final RequestStatus everythingStatus;
  final List<NewsArticleModel> newsEveryThingList;
  final String? errorMessage;

  @override
  List<Object?> get props => [
    everythingStatus,
    newsEveryThingList,
    errorMessage,
  ];

  SearchState copyWith({
    RequestStatus? everythingStatus,
    List<NewsArticleModel>? newsEveryThingList,
    String? errorMessage,
  }) {
    return SearchState(
      everythingStatus: everythingStatus ?? this.everythingStatus,
      newsEveryThingList: newsEveryThingList ?? this.newsEveryThingList,
      errorMessage: errorMessage,
    );
  }
}
