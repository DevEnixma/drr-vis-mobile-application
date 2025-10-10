part of 'news_bloc.dart';

enum NewsStatus {
  initial,
  loading,
  success,
  error,
}

class NewsState extends Equatable {
  final NewsStatus? newsesStatus;
  final List<NewsModelRes>? newses;
  final String? newsesError;
  final bool? newsesLoadMore;
  final int? newsTotal;

  const NewsState({
    this.newsesStatus = NewsStatus.initial,
    this.newses = const [],
    this.newsesError = '',
    this.newsesLoadMore = false,
    this.newsTotal = 0,
  });

  NewsState copyWith({
    NewsStatus? newsesStatus,
    List<NewsModelRes>? newses,
    String? newsesError,
    bool? newsesLoadMore,
    int? newsTotal,
  }) {
    return NewsState(
      newsesStatus: newsesStatus ?? this.newsesStatus,
      newses: newses ?? this.newses,
      newsesError: newsesError ?? this.newsesError,
      newsesLoadMore: newsesLoadMore ?? this.newsesLoadMore,
      newsTotal: newsTotal ?? this.newsTotal,
    );
  }

  @override
  List<Object?> get props => [
        newsesStatus,
        newses,
        newsesError,
        newsesLoadMore,
        newsTotal,
      ];
}
