import 'package:dio/dio.dart';
import 'package:portalberita/common/const.dart';
import 'package:portalberita/models/news.dart';
import 'package:portalberita/utils/logging_interceptor.dart';

class ApiProvider {
  Dio get dio => _dio();
  Dio _dio() {
    final options = BaseOptions(
      baseUrl: "https://newsapi.org/v2/everything",
      connectTimeout: 20000,
      receiveTimeout: 50000,
      contentType: "application/json;charset=utf-8",
    );

    var dio = Dio(options);

    dio.interceptors.add(LoggingInterceptor());

    return dio;
  }

  Future<NewsResponse> getNews(String keyword, String page) async {
    try {
      Response response = await dio.get("?q=$keyword&apiKey=${Const.apiKeyNews}&page=$page&pageSize=20");
      return NewsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
