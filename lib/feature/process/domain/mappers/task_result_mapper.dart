import 'package:webspark/feature/home/domain/models/point_model.dart';
import 'package:webspark/feature/process/data/dto/path_result/path_result_dto.dart';
import 'package:webspark/feature/process/data/dto/point/point_dto.dart';
import 'package:webspark/feature/process/data/dto/task_result/task_result_dto.dart';
import 'package:webspark/feature/process/domain/models/task_result_model.dart';

extension TaskResultModelMapper on TaskResultModel {
  TaskResultDto toDto() => TaskResultDto(
    id: task.id,
    result: PathResultDto(steps: steps.map((p) => p.toDto()).toList(growable: false), path: path),
  );
}

extension PointModelMapper on PointModel {
  PointDto toDto() => PointDto(x: x, y: y);
}
