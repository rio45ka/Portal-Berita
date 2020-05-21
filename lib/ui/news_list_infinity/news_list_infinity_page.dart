import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portalberita/bloc/news_page_infinity/news_list_bloc.dart';
import 'package:portalberita/common/loading.dart';
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
  bool isLoadMore = false;
  int page = 1;
  List<Article> articles = [];
  NewsListInfinityBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<NewsListInfinityBloc>(context);
    _bloc.add(FetchNews(widget.keywordNews, page.toString()));
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!isLoadMore) {
          isLoadMore = true;
          _bloc.add(FetchNews(widget.keywordNews, page.toString()));
          print("end");
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoadMore ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(widget.keywordNews)),
      body: BlocBuilder<NewsListInfinityBloc, NewsListInfinityState>(
        builder: (context, state) {
          if (state is NewsListInitial) {
            return Loading(message: "Mohon tunggu . . .");
          // } else if (state is NewsListLoading) {
          //   if (articles.isEmpty) {
          //     return Loading(message: "Mengambil Data . . .");
          //   }
          //   return Container(color: Colors.transparent);
          } else if (state is NewsListLoaded) {
            articles.addAll(state.response.articles);
            page += 1;
            isLoadMore = false;
            return _buildListNews();
          } else if (state is NewsListLoadFailure) {
            isLoadMore = false;
            return _buildErrorWidget();
          } else {
            return Loading(message: "Loading");
          }
        },
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildListNews() {
    return ListView.builder(
      itemCount: articles.length + 1,
      itemBuilder: (context, index) {
        if (index == articles.length) {
          return _buildProgressIndicator();
        } else
          return ItemNewsWidget(article: articles[index]);
      },
      controller: _scrollController,
    );
  }

  Widget _buildErrorWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Terjadi kesalahan!"),
      ],
    ));
  }
}
