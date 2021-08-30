// import 'package:dio/dio.dart';
// import '../config/newsInterceptor.dart';
// import '../config/news_exceptions.dart';

// const BASE_URL = "https://www.geo.tv/";

// class TopStoryNewsService {
//   TopStoryNewsService() {
//     init();
//   }
//   late Dio _dio;

//   Future<Response> getArticles(String path) async {
//     Response response;
//     try {
//       response = await _dio.get(
//         path,
//       );
//     } on DioError catch (e) {
//       throw NewsExceptions.fromDioError(e);
//     }
//     return response;
//   }

//   void init() async {
//     var options = BaseOptions(
//       baseUrl: BASE_URL,
//       connectTimeout: 5000,
//       receiveTimeout: 3000,
//     );
//     _dio = Dio(options);

//     _dio.interceptors.add(NewsInterceptor());
//   }
// }
