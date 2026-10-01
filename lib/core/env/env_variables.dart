part of 'env.dart';

abstract class _EnvVariables {
  static String get baseUrl => 'BASE_URL'.env;
}

_EnvData get _env => _EnvData._(_EnvVariables.baseUrl);

class _EnvData extends Equatable {
  const _EnvData._(this.baseUrl);

  final String baseUrl;

  @override
  List<Object?> get props => [baseUrl];
}
