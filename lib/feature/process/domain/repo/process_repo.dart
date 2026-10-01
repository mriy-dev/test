import 'package:webspark/core/api/base/exception/app_exception.dart';
import 'package:webspark/feature/process/domain/models/result_check_model.dart';
import 'package:webspark/feature/process/domain/models/task_result_model.dart';

abstract class ProcessRepo {
  Future<AppEither<List<ResultCheckModel>>> sendResults(List<TaskResultModel> results);
}
