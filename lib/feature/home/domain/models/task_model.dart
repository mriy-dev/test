import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark/feature/home/domain/models/point_model.dart';

part 'task_model.freezed.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required List<String> field,
    required PointModel start,
    required PointModel end,
  }) = _TaskModel;
}
