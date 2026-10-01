import 'package:webspark/feature/home/data/response/point/point_response.dart';
import 'package:webspark/feature/home/data/response/task/task_response.dart';
import 'package:webspark/feature/home/data/response/tasks/tasks_response.dart';
import 'package:webspark/feature/home/domain/models/point_model.dart';
import 'package:webspark/feature/home/domain/models/task_model.dart';

extension TasksResponseMapper on TasksResponse {
  List<TaskModel> toDomain() => data.map((task) => task.toDomain()).toList(growable: false);
}

extension TaskResponseMapper on TaskResponse {
  TaskModel toDomain() =>
      TaskModel(id: id, field: field, start: start.toDomain(), end: end.toDomain());
}

extension PointResponseMapper on PointResponse {
  PointModel toDomain() => PointModel(x: x, y: y);
}
