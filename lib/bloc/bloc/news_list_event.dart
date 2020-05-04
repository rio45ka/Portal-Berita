part of 'news_list_bloc.dart';

abstract class NewsListEvent extends Equatable {
  const NewsListEvent();

  @override
  List<Object> get props => [];
}

class FetchNews extends NewsListEvent {
  final String keyword;
  final String page;

  const FetchNews(this.keyword, this.page);

  @override
  List<Object> get props => [keyword, page];

  @override
  String toString() {
    return 'Search news { keyword: $keyword, page: $page}';
  }

}
