import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:webspark/core/api/base/exception/app_exception.dart';
import 'package:webspark/feature/process/data/gateway/process_gateway.dart';
import 'package:webspark/feature/process/domain/mappers/result_check_mapper.dart';
import 'package:webspark/feature/process/domain/mappers/task_result_mapper.dart';
import 'package:webspark/feature/process/domain/models/result_check_model.dart';
import 'package:webspark/feature/process/domain/models/task_result_model.dart';
import 'package:webspark/feature/process/domain/repo/process_repo.dart';

@Injectable(as: ProcessRepo)
class ProcessRepoImpl extends ProcessRepo {
  final ProcessGateway _gateway;

  ProcessRepoImpl(this._gateway);

  @override
  Future<AppEither<List<ResultCheckModel>>> sendResults(List<TaskResultModel> results) async {
    final result = await _gateway.sendResults(
      results.map((r) => r.toDto()).toList(growable: false),
    );

    return result.fold(Left.new, (response) {
      if (response.error) {
        return Left(AppException(message: response.message, response: response.toJson()));
      }

      return Right(response.toDomain());
    });
  }
}
