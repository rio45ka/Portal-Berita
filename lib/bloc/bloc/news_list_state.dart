part of 'news_list_bloc.dart';

abstract class NewsListState extends Equatable {
  const NewsListState();
}

class NewsListInitial extends NewsListState {
  @override
  List<Object> get props => [];
}
