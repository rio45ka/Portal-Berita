import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portalberita/bloc/news_page/news_list_bloc.dart';
import 'package:portalberita/common/loading.dart';
import 'package:portalberita/common/widget/item_news_widget.dart';
import 'package:portalberita/models/news.dart';

class NewsListPage extends StatefulWidget {
  final String keywordNews;

  const NewsListPage({Key key, @required this.keywordNews}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    BlocProvider.of<NewsListBloc>(context).add(FetchNews(widget.keywordNews, "1"));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(widget.keywordNews)),
      body: BlocBuilder<NewsListBloc, NewsListState>(
        builder: (context, state) {
          if (state is NewsListInitial) {
            return Loading(message: "Mohon tunggu . . .");
          } else if (state is NewsListLoadingProgress) {
            return Loading(message: "Mengambil Data . . .");
          } else if (state is NewsListLoadSuccess) {
            return _buildListNews(state.response.articles);
          } else if (state is NewsListLoadFailure) {
            return _buildErrorWidget();
          } else {
            return Loading(message: "Loading");
          }
        },
      ),
    );
  }

  Widget _buildListNews(List<Article> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => ItemNewsWidget(article: data[index])
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
