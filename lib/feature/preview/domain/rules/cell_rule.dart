import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark/feature/home/domain/models/point_model.dart';
import 'package:webspark/feature/preview/domain/cell_type.dart';
import 'package:webspark/feature/process/domain/models/task_result_model.dart';
import 'package:webspark/feature/process/domain/services/path_finding/grid.dart';

part 'cell_rule.freezed.dart';

@freezed
sealed class CellRule with _$CellRule {
  const factory CellRule.start() = StartCellRule;

  const factory CellRule.end() = EndCellRule;

  const factory CellRule.blocked() = BlockedCellRule;

  const factory CellRule.path() = PathCellRule;

  const CellRule._();

  CellType? resolve(PointModel cell, TaskResultModel result) => switch (this) {
    StartCellRule() => cell == result.task.start ? CellType.start : null,
    EndCellRule() => cell == result.task.end ? CellType.end : null,
    BlockedCellRule() => Grid(result.task.field).isBlocked(cell) ? CellType.blocked : null,
    PathCellRule() => result.steps.contains(cell) ? CellType.path : null,
  };
}
