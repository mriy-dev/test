import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark/feature/home/domain/models/point_model.dart';
import 'package:webspark/feature/home/domain/models/task_model.dart';

part 'task_result_model.freezed.dart';

@freezed
abstract class TaskResultModel with _$TaskResultModel {
  const factory TaskResultModel({required TaskModel task, required List<PointModel> steps}) =
      _TaskResultModel;

  const TaskResultModel._();

  String get path => steps.map((p) => '(${p.x},${p.y})').join('->');
}
