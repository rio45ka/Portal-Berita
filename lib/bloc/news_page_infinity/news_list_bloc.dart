import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    if (event is FetchNews) {
      yield NewsListLoading();
      try {
        yield* _searchWithKeyword(keyword: event.keyword, page: event.page);
      } catch (_) {
        yield NewsListLoadFailure();
      }
    }
  }

  Stream<NewsListInfinityState> _searchWithKeyword({
    String keyword,
    String page,
  }) async* {
    yield NewsListLoading();
    try {
      final NewsResponse _response = await _repository.getNews(keyword: keyword, page: page);
      yield NewsListLoaded(response: _response);
    } catch (_) {
      yield NewsListLoadFailure();
    }
  }
}
