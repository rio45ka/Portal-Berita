import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portalberita/bloc/news_page_infinity/news_list_bloc.dart';
import 'package:portalberita/common/widget/bottom_loader_widget.dart';
import 'package:portalberita/common/widget/item_news_widget.dart';
import 'package:portalberita/models/news.dart';

class NewsListInfinityPage extends StatefulWidget {
  final String keywordNews;

  const NewsListInfinityPage({Key key, @required this.keywordNews})
      : super(key: key);

  @override
  _NewsListInfinityPageState createState() => _NewsListInfinityPageState();
}

class _NewsListInfinityPageState extends State<NewsListInfinityPage> {
  ScrollController _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  List<Article> articles = [];
  NewsListInfinityBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<NewsListInfinityBloc>(context);
    _scrollController.addListener(_onScroll);
    _bloc.add(FetchNews(widget.keywordNews, ""));
    super.initState();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     print("end");
    //   }
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(widget.keywordNews)),
      body: BlocBuilder<NewsListInfinityBloc, NewsListInfinityState>(
        builder: (context, state) {
          if (state is NewsListLoadFailure) {
            return Center(
              child: Text('Gagal mengambil data artikel'),
            );
          }
          if (state is NewsListLoaded) {
            if (state.articles.isEmpty) {
              return Center(
                child: Text('Tidak ada artikel'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.articles.length
                    ? BottomLoader()
                    : ItemNewsWidget(article: state.articles[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.articles.length
                  : state.articles.length + 1,
              controller: _scrollController,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _bloc.add(FetchNews(widget.keywordNews, ""));
    }
  }
}
