import 'package:webspark/feature/process/domain/models/task_result_model.dart';

extension TaskResultModelX on TaskResultModel {
  bool get hasPath => steps.isNotEmpty;

  String get displayPath => hasPath ? path : 'No path found';
}
