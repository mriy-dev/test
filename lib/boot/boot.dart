import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:webspark/core/api/webspark_api.dart';
import 'package:webspark/core/env/env.dart';
import 'package:webspark/core/network/dio_client.dart';

import 'boot.config.dart';

final get = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  final talker = Talker(
    settings: TalkerSettings(useConsoleLogs: kDebugMode),
    logger: TalkerLogger(
      settings: TalkerLoggerSettings(enableColors: false),
      output: (message) => debugPrint(message),
    ),
  );
  get.registerLazySingleton<Talker>(() => talker);

  Bloc.observer = TalkerBlocObserver(talker: talker);

  get.init();

  get.registerLazySingleton<Dio>(
    () => createDio(baseUrl: kEnv.baseUrl, talker: talker, enableLogging: kDebugMode),
  );
  get.registerLazySingleton<WebsparkApi>(() => WebsparkApi(get<Dio>()));
}
