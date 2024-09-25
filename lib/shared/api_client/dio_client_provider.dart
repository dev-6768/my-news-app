import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_news_app/const/string_constants.dart';
import 'package:my_news_app/shared/api_client/bad_certificate_fixer.dart';
import 'package:my_news_app/shared/api_client/default_api_interceptor.dart';
import 'package:my_news_app/shared/api_client/default_time_response_interceptor.dart';
import 'package:my_news_app/shared/api_client/form_data_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:platform_info/platform_info.dart';

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

final dioProvider = Provider.autoDispose<Dio>(
  (ref) {
    final dio = Dio();
    dio.options.baseUrl = StringConstants.developmentBaseUrl;
    if (kDebugMode) {
      dio.interceptors.add(TimeResponseInterceptor());
      dio.interceptors.add(FormDataInterceptor());
      dio.interceptors.add(
        TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
          ),
        ),
      );
    }

    dio.interceptors.addAll([
      DefaultAPIInterceptor(dio: dio),
    ]);
    fixBadCertificate(dio: dio);
    return dio;
  },
  name: 'dioProvider',
);
