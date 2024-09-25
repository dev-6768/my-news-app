// ignore_for_file: strict_raw_type
// coverage:ignore-file
import 'package:dio/dio.dart';

///This Interceptor is used check the response time from the server for each request
class TimeResponseInterceptor extends Interceptor {
  late Stopwatch stopwatch;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    stopwatch = Stopwatch()..start();

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
