import 'package:flutter/material.dart';
import 'package:webspark/feature/preview/domain/cell_type.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.cellStart,
    required this.cellEnd,
    required this.cellBlocked,
    required this.cellPath,
    required this.cellEmpty,
    required this.cellBorder,
  });

  static const light = AppColors(
    cellStart: Color(0xFF64FFDA),
    cellEnd: Color(0xFF009688),
    cellBlocked: Color(0xFF000000),
    cellPath: Color(0xFF4CAF50),
    cellEmpty: Color(0xFFFFFFFF),
    cellBorder: Color(0xFFBDBDBD),
  );

  final Color cellStart;
  final Color cellEnd;
  final Color cellBlocked;
  final Color cellPath;
  final Color cellEmpty;
  final Color cellBorder;

  Color cellColor(CellType type) => switch (type) {
    CellType.start => cellStart,
    CellType.end => cellEnd,
    CellType.blocked => cellBlocked,
    CellType.path => cellPath,
    CellType.empty => cellEmpty,
  };

  Color cellTextColor(CellType type) =>
      cellColor(type).computeLuminance() < 0.4 ? Colors.white : Colors.black;

  @override
  AppColors copyWith({
    Color? cellStart,
    Color? cellEnd,
    Color? cellBlocked,
    Color? cellPath,
    Color? cellEmpty,
    Color? cellBorder,
  }) => AppColors(
    cellStart: cellStart ?? this.cellStart,
    cellEnd: cellEnd ?? this.cellEnd,
    cellBlocked: cellBlocked ?? this.cellBlocked,
    cellPath: cellPath ?? this.cellPath,
    cellEmpty: cellEmpty ?? this.cellEmpty,
    cellBorder: cellBorder ?? this.cellBorder,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;

    return AppColors(
      cellStart: Color.lerp(cellStart, other.cellStart, t)!,
      cellEnd: Color.lerp(cellEnd, other.cellEnd, t)!,
      cellBlocked: Color.lerp(cellBlocked, other.cellBlocked, t)!,
      cellPath: Color.lerp(cellPath, other.cellPath, t)!,
      cellEmpty: Color.lerp(cellEmpty, other.cellEmpty, t)!,
      cellBorder: Color.lerp(cellBorder, other.cellBorder, t)!,
    );
  }
}
