import 'package:webspark/feature/home/domain/models/point_model.dart';
import 'package:webspark/feature/home/domain/models/task_model.dart';

extension TaskModelX on TaskModel {
  int get rows => field.length;

  int get columns => field.isEmpty ? 0 : field.first.length;

  int get cellCount => rows * columns;

  PointModel cellAt(int index) => PointModel(x: index % columns, y: index ~/ columns);
}
