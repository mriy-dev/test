import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

typedef AppEither<MODEL> = Either<AppException, MODEL>;

class AppException implements Exception {
  static const msgFallback = 'Something went wrong, please try again';

  const AppException({
    this.code,
    this.description = '',
    this.message = msgFallback,
    this.response = const <String, dynamic>{},
    this.isSilent = false,
  });

  final String message;
  final String description;
  final Map<String, dynamic> response;
  final int? code;
  final bool isSilent;

  @override
  String toString() {
    if (code == null && message.isEmpty) return description.firstCharToUpper();

    final messageWithCode = '$code ${message.firstCharToUpper()}'.replaceAll('null', '').trim();
    if (description.isEmpty) return messageWithCode;

    return '$messageWithCode - ${description.firstCharToUpper()}'.trim();
  }
}

extension ApiExceptionMapper on Exception {
  AppException toAppException() {
    if (this is DioException) return (this as DioException).toAppException();

    final message = toString();

    if (message == 'Exception') {
      return const AppException(message: AppException.msgFallback);
    }

    return AppException(message: message.replaceAll('Exception: ', ''));
  }
}

extension DioExceptionMapper on DioException {
  AppException toAppException() {
    final data = response?.data;
    final body = data is Map<String, dynamic> ? data : const <String, dynamic>{};

    return AppException(code: response?.statusCode, message: _resolveMessage(body), response: body);
  }

  String _resolveMessage(Map<String, dynamic> body) {
    final bodyError = body['error'];
    if (bodyError is String && bodyError.isNotEmpty) return bodyError;

    return AppException.msgFallback;
  }
}

extension ApiExceptionExtension on AppException {
  Either<int?, int> matchErrorCode(int errorCode) =>
      Either.fromPredicate(code ?? errorCode, (_) => code == errorCode, (_) => code);

  Either<String, String> matchErrorMessage(String expected) =>
      Either.fromPredicate(message, (_) => message == expected, (_) => message);
}

extension _StringFormatExtension on String {
  String firstCharToUpper() {
    if (isEmpty) return '';
    if (length <= 1) return this[0];

    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
