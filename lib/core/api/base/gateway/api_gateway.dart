import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:webspark/core/api/base/exception/app_exception.dart';

abstract class ApiGateway {
  const ApiGateway();

  @protected
  Future<AppEither<DTO>> safeCall<DTO>(AsyncValueGetter<DTO> invoker) async {
    try {
      return Right(await invoker());
    } on AppException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e.toAppException());
    } catch (e) {
      return Left(Exception(e).toAppException());
    }
  }

  @protected
  Future<AppEither<None>> voidSafeCall(AsyncCallback invoker) async {
    try {
      await invoker();

      return const Right(None());
    } on AppException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e.toAppException());
    } catch (e) {
      return Left(Exception(e).toAppException());
    }
  }
}
