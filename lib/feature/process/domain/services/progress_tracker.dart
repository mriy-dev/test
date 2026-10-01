import 'package:webspark/feature/home/domain/models/task_model.dart';
import 'package:webspark/feature/process/domain/services/path_finding/grid.dart';

class ProgressTracker {
  ProgressTracker(List<TaskModel> tasks) : _total = tasks.map(_freeCells).fold(0, (a, b) => a + b);

  final int _total;
  int _done = 0;

  static int _freeCells(TaskModel task) => Grid(task.field).freeCellCount;

  int visiting(int visitedInCurrentTask) => _percent(_done + visitedInCurrentTask);

  int completed(TaskModel task) {
    _done += _freeCells(task);

    return _percent(_done);
  }

  int _percent(int done) => _total == 0 ? 100 : (done * 100 ~/ _total).clamp(0, 100);
}
