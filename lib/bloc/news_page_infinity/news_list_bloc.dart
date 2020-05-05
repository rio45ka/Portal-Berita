import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portalberita/models/news.dart';
import 'package:portalberita/repository/news_repository.dart';

part 'news_list_event.dart';
part 'news_list_state.dart';

class NewsListInfinityBloc
    extends Bloc<NewsListInfinityEvent, NewsListInfinityState> {
  NewsRepository _repository = NewsRepository();

  @override
  NewsListInfinityState get initialState => NewsListInitial();

  @override
  Stream<NewsListInfinityState> mapEventToState(
    NewsListInfinityEvent event,
  ) async* {
    final currentState = state;

    if (event is FetchNews && !_hasReachedMax(currentState)) {
      try {
        if (currentState is NewsListInitial) {
          final posts = await _fetchArticle(event.keyword, "1");
          yield NewsListLoaded(articles: posts, hasReachedMax: false);
          return;
        }
        if (currentState is NewsListLoaded) {
          final posts = await _fetchArticle(
              event.keyword, getPage(currentState.articles.length + 1).toString());
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : NewsListLoaded(
                  articles: currentState.articles + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield NewsListLoadFailure();
      }
    }
  }

  int getPage(int length) {
    var page = length / 20;
    return page.toInt();
  }

  bool _hasReachedMax(NewsListInfinityState state) =>
      state is NewsListLoaded && state.hasReachedMax;

  Future<List<Article>> _fetchArticle(String keyword, String page) async {
    final response = await _repository.getNews(keyword: keyword, page: page);
    if (response.status == "ok") {
      return response.articles;
    } else {
      throw Exception('error fetching posts');
    }
  }
}
