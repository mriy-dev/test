import 'package:flutter/material.dart';
import 'package:webspark/core/extensions/theme_extension.dart';
import 'package:webspark/feature/home/domain/models/point_model.dart';
import 'package:webspark/feature/preview/domain/cell_type.dart';

class PathCell extends StatelessWidget {
  const PathCell({super.key, required this.point, required this.type});

  final PointModel point;
  final CellType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.cellColor(type),
        border: Border.all(color: colors.cellBorder, width: 0.5),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              '(${point.x},${point.y})',
              style: context.textTheme.bodySmall?.copyWith(color: colors.cellTextColor(type)),
            ),
          ),
        ),
      ),
    );
  }
}
