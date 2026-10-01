import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:webspark/core/api/base/exception/app_exception.dart';
import 'package:webspark/core/api/base/gateway/api_gateway.dart';
import 'package:webspark/core/api/store/api_url_store.dart';

@lazySingleton
class BaseUrlGateway extends ApiGateway {
  const BaseUrlGateway(this._urlStore);

  final ApiUrlStore _urlStore;

  String? get savedUrl => _urlStore.url;

  Future<AppEither<None>> setUrl(String url) => voidSafeCall(() => _urlStore.save(url));
}
