import 'package:flutter_test/flutter_test.dart';
import 'package:webspark/feature/home/domain/models/point_model.dart';
import 'package:webspark/feature/home/domain/models/task_model.dart';
import 'package:webspark/feature/process/domain/models/task_result_model.dart';
import 'package:webspark/feature/process/domain/services/path_finding/move_rules.dart';
import 'package:webspark/feature/process/domain/services/path_finding/path_finder.dart';

void main() {
  test('spec example: (1,2) -> (2,1) -> (2,0)', () async {
    const task = TaskModel(
      id: 'spec',
      field: ['.X.', '.X.', '...'],
      start: PointModel(x: 1, y: 2),
      end: PointModel(x: 2, y: 0),
    );

    final steps = await const PathFinder(EightDirectionMoveRules()).find(task);
    final result = TaskResultModel(task: task, steps: steps);

    expect(result.path, '(1,2)->(2,1)->(2,0)');
  });
}
