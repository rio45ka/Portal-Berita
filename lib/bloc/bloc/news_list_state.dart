part of 'news_list_bloc.dart';

abstract class NewsListState extends Equatable {
  const NewsListState();

  @override
  List<Object> get props => [];
}

class NewsListInitial extends NewsListState {
  
}

class NewsListLoadingProgress extends NewsListState {}

class NewsListLoadSuccess extends NewsListState{
  final NewsResponse response;

  const NewsListLoadSuccess({@required this.response})
      : assert(response != null);

  @override
  List<Object> get props => [response];
}

class NewsListLoadFailure extends NewsListState {}
