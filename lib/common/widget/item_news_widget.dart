import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portalberita/models/news.dart';
import 'package:portalberita/utils/ui_background.dart';

class ItemNewsWidget extends StatelessWidget {
  final Article article;

  const ItemNewsWidget({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildImage(context),
          SizedBox(height: 15.0),
          _buildDescItemNews(context),
          SizedBox(height: 15.0)
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [bgBoxShadowContainer()],
        color: Colors.white,
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
      child: CachedNetworkImage(
        imageUrl: article.urlToImage,
        height: 150.0,
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _buildDescItemNews(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            article.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            article.description,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Rachel England',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
