import 'package:injectable/injectable.dart';
import 'package:webspark/core/api/base/exception/app_exception.dart';
import 'package:webspark/core/api/base/gateway/api_gateway.dart';
import 'package:webspark/core/api/webspark_api.dart';
import 'package:webspark/feature/process/data/dto/task_result/task_result_dto.dart';
import 'package:webspark/feature/process/data/response/results/results_response.dart';

@lazySingleton
class ProcessGateway extends ApiGateway {
  const ProcessGateway(this._api);

  final WebsparkApi _api;

  Future<AppEither<ResultsResponse>> sendResults(List<TaskResultDto> results) =>
      safeCall(() => _api.sendResults(results));
}
