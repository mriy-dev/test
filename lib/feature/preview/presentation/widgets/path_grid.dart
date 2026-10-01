import 'package:flutter/material.dart';
import 'package:webspark/core/extensions/task_extension.dart';
import 'package:webspark/feature/preview/domain/cell_type_resolver.dart';
import 'package:webspark/feature/preview/presentation/widgets/path_cell.dart';
import 'package:webspark/feature/process/domain/models/task_result_model.dart';

class PathGrid extends StatelessWidget {
  PathGrid({super.key, required this.result, CellTypeResolver? resolver})
    : resolver = resolver ?? CellTypeResolver.standard();

  final TaskResultModel result;
  final CellTypeResolver resolver;

  @override
  Widget build(BuildContext context) {
    final task = result.task;
    if (task.columns == 0) return const SizedBox.shrink();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: task.columns),
      itemCount: task.cellCount,
      itemBuilder: (context, index) {
        final point = task.cellAt(index);

        return PathCell(point: point, type: resolver.resolve(point, result));
      },
    );
  }
}
