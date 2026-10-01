// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'env.freezed.dart';
part 'env_parser.dart';
part 'env_variables.dart';

_EnvData get kEnv => kEnvHelper.data;

_Env get kEnvHelper => _Env();

Future<void> initEnv() async {
  if (!_parser.isInitialized) await _parser.load();
}

@freezed
sealed class _Env with _$Env {
  static _Env? _instance;

  factory _Env() {
    assert(_parser.isInitialized, 'kEnv not initialized, call initEnv() first');

    return _instance ??= _Env.dev(_env);
  }

  const factory _Env.dev(final _EnvData data) = _Dev;
}
