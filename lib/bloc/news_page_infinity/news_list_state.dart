part of 'news_list_bloc.dart';

abstract class NewsListInfinityState extends Equatable {
  const NewsListInfinityState();

  @override
  List<Object> get props => [];
}

class NewsListInitial extends NewsListInfinityState {}

class NewsListLoading extends NewsListInfinityState {}

class NewsListLoaded extends NewsListInfinityState {
  final List<Article> articles;
  final bool hasReachedMax;

  const NewsListLoaded({this.articles, this.hasReachedMax});

  @override
  List<Object> get props => [articles, hasReachedMax];

  NewsListLoaded copyWith({
    List<Article> list,
    bool hasReachedMax,
  }) {
    return NewsListLoaded(
      articles: list ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class NewsListLoadFailure extends NewsListInfinityState {}
