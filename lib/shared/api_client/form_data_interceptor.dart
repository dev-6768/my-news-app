import 'package:dio/dio.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:platform_info/platform_info.dart';
import 'package:flutter/foundation.dart';

final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    maxHistoryItems: 10,
    useConsoleLogs: !kReleaseMode,
    enabled: !kReleaseMode,
  ),
  logger: TalkerLogger(
    output: debugPrint,
    settings: TalkerLoggerSettings(
      enableColors: !Platform.I.iOS,
    ),
  ),
);

class FormDataInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final data = options.data;

    if (data is FormData) {
      ///print form data
      for (final item in data.fields) {
        talker.log('${item.key} : ${item.value}');
      }
    }
    super.onRequest(options, handler);
  }
}
