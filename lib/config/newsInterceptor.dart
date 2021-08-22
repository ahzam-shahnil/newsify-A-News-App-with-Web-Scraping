import 'package:dio/dio.dart';


class NewsInterceptor extends Interceptor {
  

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // log.i('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // log.i(
        // 'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // log.e('Error [${err.response!.statusMessage}]=>${err.requestOptions.path}');

    return super.onError(err, handler);
  }
}
