import 'package:dio/dio.dart';

import '../config/newsInterceptor.dart';
import '../config/news_exceptions.dart';

const BASE_URL = "https://free-news.p.rapidapi.com/v1/search?";

class NewsService {
  NewsService() {
    init();
  }
  late Dio _dio;


  Future<Response> getArticles(String path) async {
    Response response;
    try {
      response = await _dio.get(
        path,
      );
    } on DioError catch (e) {
      throw NewsExceptions.fromDioError(e);
    }
    return response;
  }

  void init() async {
    var options = BaseOptions(
      baseUrl: BASE_URL,
      headers: {
        'x-rapidapi-host': 'free-news.p.rapidapi.com',
        'x-rapidapi-key': '4a09c9017amshcf90589190998f0p181ba8jsn6860582463b5'
      },
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _dio = Dio(options);

    _dio.interceptors.add(NewsInterceptor());
  }
}
