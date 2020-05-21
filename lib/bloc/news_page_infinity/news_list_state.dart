part of 'news_list_bloc.dart';

abstract class NewsListInfinityState extends Equatable {
  const NewsListInfinityState();

  @override
  List<Object> get props => [];
}

class NewsListInitial extends NewsListInfinityState {}

class NewsListLoading extends NewsListInfinityState {}

class NewsListLoaded extends NewsListInfinityState {
  final NewsResponse response;

  const NewsListLoaded({@required this.response})
      : assert(response != null);

  @override
  List<Object> get props => [response];
}

class NewsListLoadFailure extends NewsListInfinityState {}
