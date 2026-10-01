import 'package:injectable/injectable.dart';
import 'package:webspark/feature/home/domain/models/point_model.dart';
import 'package:webspark/feature/process/domain/services/path_finding/direction.dart';
import 'package:webspark/feature/process/domain/services/path_finding/grid.dart';

abstract interface class MoveRules {
  Iterable<PointModel> availableMoves(PointModel from, Grid grid);
}

@LazySingleton(as: MoveRules)
class EightDirectionMoveRules implements MoveRules {
  const EightDirectionMoveRules();

  @override
  Iterable<PointModel> availableMoves(PointModel from, Grid grid) =>
      Direction.values.map((d) => d.moveFrom(from)).where(grid.isFree);
}
