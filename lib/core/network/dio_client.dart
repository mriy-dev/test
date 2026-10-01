import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:webspark/core/api/store/api_url_store.dart';
import 'package:webspark/core/network/api_url_interceptor.dart';

Dio createDio({required ApiUrlStore urlStore, required Talker talker, bool enableLogging = false}) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      headers: const {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.add(ApiUrlInterceptor(urlStore));

  if (enableLogging) {
    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: false,
          printResponseMessage: true,
        ),
      ),
    );
  }

  return dio;
}
