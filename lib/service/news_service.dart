// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:logger/logger.dart';
// import 'package:news_app_test/config/environment_config.dart';

// import '../config/news_exceptions.dart';
// import '../controller/NewsAPiController.dart';
// import '../model/article.dart';

// class NewsService {
//   NewsService(this._dio);
//   final Dio _dio;


//   Logger log = Logger();
//   EnvironmentConfig environmentConfig = EnvironmentConfig();
//   final apiPath = Get.find<NewsApiController>();

//   Future<List<Article>> getArticles() async {
    
//     try {
//       final response = await _dio.get(
//         'v2/top-headlines?country=${apiPath.country.value}&category=${apiPath.category.value}',
//       );

//       final results = List<Map<String, dynamic>>.from(
//         response.data['articles'],
//       );

//       final List<Article> articles =
//           List<Article>.from(results.map((x) => Article.fromJson(x)))
//               .toList(growable: false);
//       return articles;
//     } on DioError catch (e) {
//       if (e.response != null) {
//         log.e(
//             'Status : ${e.response?.statusCode} \n Data : ${e.response?.data} \n Headers : ${e.response?.headers}');
//       } else {
//         log.e('Error Sending Request \n ${e.message}');
//       }
//       throw NewsExceptions.fromDioError(e);
//     }
//   }

//   // Future<List<Source>> getSources(String path) async {
//   //   try {
//   //     final response = await _dio.get(path);

//   //     final results = List<Map<String, dynamic>>.from(
//   //       response.data['sources'],
//   //     );

//   //     final List<Source> sources = results
//   //         .map((sourceData) => Source.fromMap(sourceData))
//   //         .toList(growable: false);

//   //     return sources;
//   //   } on DioError catch (e) {
//   //     throw NewsExceptions.fromDioError(e);
//   //   }
// }
