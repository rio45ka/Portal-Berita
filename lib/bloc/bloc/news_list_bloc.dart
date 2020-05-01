import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'news_list_event.dart';
part 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  @override
  NewsListState get initialState => NewsListInitial();

  @override
  Stream<NewsListState> mapEventToState(
    NewsListEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
