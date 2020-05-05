import 'package:flutter/material.dart';
import 'package:portalberita/ui/news_list/news_list_page.dart';
import 'package:portalberita/ui/news_list_infinity/news_list_infinity_page.dart';
import 'package:portalberita/utils/utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  String _searchKeyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Portal Berita')),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final buildBtn = () {
      return SizedBox(
        height: 52.0,
        width: double.infinity,
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _openPageNewsList();
            }
          },
          child: Text(
            'Cari',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.red,
        ),
      );
    };

    final buildInputKeyword = () {
      return TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Tidak boleh kosong!';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: 'Keyword Berita',
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          onSaved: (value) => _searchKeyword = value);
    };

    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Masukan keyword pencarian berita',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.0),
              buildInputKeyword(),
              SizedBox(height: 30.0),
              buildBtn(),
            ],
          ),
        ),
      ),
    );
  }

  void _openPageNewsList() {
    _formKey.currentState.save();
    pageOpen(context, NewsListInfinityPage(keywordNews: _searchKeyword));
  }
}
