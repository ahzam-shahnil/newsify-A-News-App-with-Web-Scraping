
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:news_app_test/config/environment_config.dart';
import 'package:news_app_test/config/newsInterceptor.dart';
import 'package:news_app_test/config/news_exceptions.dart';

const BASE_URL = "https://newsapi.org/";

class NewsService {
  NewsService() {
    init();
  }
  late Dio _dio;
  Logger log = Logger();

  EnvironmentConfig environmentConfig = EnvironmentConfig();

  Future<Response> getArticles(String path) async {
    Response response;
    try {
      response = await _dio.get(
        path,
      );
    } on DioError catch (e) {
      if (e.response != null) {
        log.e(
            'Status : ${e.response?.statusCode} \n Data : ${e.response?.data} \n Headers : ${e.response?.headers}');
      } else {
        log.e('Error Sending Request \n ${e.message}');
      }
      throw NewsExceptions.fromDioError(e);
    }
    return response;
  }


  void init() {
    var options = BaseOptions(
      baseUrl: BASE_URL,
      headers: {"Authorization": "${environmentConfig.newsApiKey}"},
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _dio = Dio(options);
    

    _dio.interceptors.add(NewsInterceptor());
  }
}
