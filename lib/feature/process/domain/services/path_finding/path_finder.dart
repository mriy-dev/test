import 'dart:async';
import 'dart:collection';

import 'package:injectable/injectable.dart';
import 'package:webspark/feature/home/domain/models/point_model.dart';
import 'package:webspark/feature/home/domain/models/task_model.dart';
import 'package:webspark/feature/process/domain/services/path_finding/grid.dart';
import 'package:webspark/feature/process/domain/services/path_finding/move_rules.dart';

typedef VisitCallback = FutureOr<void> Function(int visited);

@lazySingleton
class PathFinder {
  const PathFinder(this._moves);

  final MoveRules _moves;

  Future<List<PointModel>> find(TaskModel task, {VisitCallback? onVisit}) async {
    final grid = Grid(task.field);
    final start = task.start;
    final end = task.end;
    if (!grid.isFree(start) || !grid.isFree(end)) return const [];

    final cameFrom = <PointModel, PointModel>{start: start};
    final queue = Queue<PointModel>()..add(start);
    var visited = 0;

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      await onVisit?.call(++visited);
      if (current == end) return _pathTo(end, cameFrom);

      for (final next in _moves.availableMoves(current, grid)) {
        if (cameFrom.containsKey(next)) continue;
        cameFrom[next] = current;
        queue.add(next);
      }
    }

    return const [];
  }

  List<PointModel> _pathTo(PointModel end, Map<PointModel, PointModel> cameFrom) {
    final path = [end];
    while (cameFrom[path.last] != path.last) {
      path.add(cameFrom[path.last]!);
    }

    return path.reversed.toList();
  }
}
