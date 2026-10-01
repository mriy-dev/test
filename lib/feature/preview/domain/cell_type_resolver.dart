import 'package:webspark/feature/home/domain/models/point_model.dart';
import 'package:webspark/feature/preview/domain/cell_type.dart';
import 'package:webspark/feature/preview/domain/rules/cell_rule.dart';
import 'package:webspark/feature/process/domain/models/task_result_model.dart';

class CellTypeResolver {
  const CellTypeResolver(this.rules, {this.fallback = CellType.empty});

  factory CellTypeResolver.standard() => const CellTypeResolver([
    CellRule.start(),
    CellRule.end(),
    CellRule.blocked(),
    CellRule.path(),
  ]);

  final List<CellRule> rules;
  final CellType fallback;

  CellType resolve(PointModel cell, TaskResultModel result) {
    for (final rule in rules) {
      final type = rule.resolve(cell, result);
      if (type != null) return type;
    }

    return fallback;
  }
}
