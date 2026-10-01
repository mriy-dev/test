import 'package:injectable/injectable.dart';
import 'package:webspark/core/api/base/exception/app_exception.dart';
import 'package:webspark/core/api/base/gateway/api_gateway.dart';
import 'package:webspark/core/api/webspark_api.dart';
import 'package:webspark/feature/home/data/response/tasks/tasks_response.dart';

@lazySingleton
class TasksGateway extends ApiGateway {
  const TasksGateway(this._api);

  final WebsparkApi _api;

  Future<AppEither<TasksResponse>> getTasks() => safeCall(_api.getTasks);
}
