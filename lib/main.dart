import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portalberita/bloc/bloc/news_list_bloc.dart';
import 'package:portalberita/ui/home/home_page.dart';

void main() {
  runApp(BlocProvider<NewsListBloc>(
    create: (context) => NewsListBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal berita',
      theme: ThemeData(
        primarySwatch: Colors.green,
        canvasColor: Colors.transparent,
      ),
      home: HomePage(),
    );
  }
}