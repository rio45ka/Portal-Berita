import 'package:portalberita/models/news.dart';
import 'package:portalberita/repository/api_provider.dart';

class NewsRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<NewsResponse> getNews({String keyword, String page}) => _apiProvider.getNews(keyword, page);
}