import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

typedef AppEither<MODEL> = Either<AppException, MODEL>;

class AppException implements Exception {
  static const msgFallback = 'Something went wrong, please try again';
  static const msgUnexpectedResponse = 'Server returned an unexpected response, check the URL';
  static const msgUnreachable = 'Could not reach the server, check the URL and your connection';
  static const msgTimeout = 'The server did not respond in time, try again';
  static const msgBadCertificate = 'The server certificate is not trusted';
  static const msgNotFound = 'Nothing found at this URL, check the address';
  static const msgServerError = 'The server failed to process the request, try again later';

  const AppException({
    this.code,
    this.message = msgFallback,
    this.response = const <String, dynamic>{},
  });

  final String message;
  final Map<String, dynamic> response;
  final int? code;

  @override
  String toString() => code == null ? message : '$code $message';
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
    final bodyMessage = body['message'];
    if (bodyMessage is String && bodyMessage.isNotEmpty) return bodyMessage;

    final bodyError = body['error'];
    if (bodyError is String && bodyError.isNotEmpty) return bodyError;

    return switch (type) {
      DioExceptionType.connectionError => AppException.msgUnreachable,
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => AppException.msgTimeout,
      DioExceptionType.badCertificate => AppException.msgBadCertificate,
      DioExceptionType.badResponse => switch (response?.statusCode) {
        404 => AppException.msgNotFound,
        final code? when code >= 500 => AppException.msgServerError,
        _ => AppException.msgFallback,
      },
      _ => AppException.msgFallback,
    };
  }
}
