import 'package:dio/dio.dart';
import 'package:webspark/core/api/store/api_url_store.dart';

class ApiUrlInterceptor extends Interceptor {
  const ApiUrlInterceptor(this._store);

  final ApiUrlStore _store;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final uri = Uri.tryParse(_store.url ?? '');
    if (uri == null || uri.host.isEmpty) {
      return handler.reject(DioException(requestOptions: options, message: 'API URL is not set'));
    }

    options.baseUrl = uri
        .replace(queryParameters: const {}, fragment: '')
        .toString()
        .replaceFirst(RegExp(r'[?#]+$'), '');
    options.queryParameters = {...uri.queryParameters, ...options.queryParameters};

    handler.next(options);
  }
}
