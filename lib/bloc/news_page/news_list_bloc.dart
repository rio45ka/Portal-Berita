import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:portalberita/models/news.dart';
import 'package:portalberita/repository/news_repository.dart';

part 'news_list_event.dart';
part 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  NewsRepository _repository = NewsRepository();

  @override
  NewsListState get initialState => NewsListInitial();

  @override
  Stream<NewsListState> mapEventToState(
    NewsListEvent event,
  ) async* {
    if (event is FetchNews) {
      yield NewsListLoadingProgress();
      try {
        yield* _searchWithKeyword(keyword: event.keyword, page: event.page);
      } catch (_) {
        yield NewsListLoadFailure();
      }
    }
  }

  Stream<NewsListState> _searchWithKeyword({
    String keyword,
    String page,
  }) async* {
    yield NewsListLoadingProgress();
    try {
      final NewsResponse _response = await _repository.getNews(keyword: keyword, page: page);
      yield NewsListLoadSuccess(response: _response);
    } catch (_) {
      yield NewsListLoadFailure();
    }
  }
}
