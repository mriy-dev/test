import 'package:flutter/material.dart';
import 'package:webspark/core/theme/app_colors.dart';

abstract final class AppTheme {
  static const _seed = Color(0xFF2196F3);
  static const _buttonFill = Color(0xFF40C4FF);
  static const _buttonBorder = Color(0xFF448AFF);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(seedColor: _seed);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      extensions: const [AppColors.light],
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
      ),
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          ),
          minimumSize: WidgetStatePropertyAll(Size(double.infinity, 44)),
          backgroundColor: WidgetStatePropertyAll(_buttonFill),
          foregroundColor: WidgetStatePropertyAll(Colors.black),
          side: WidgetStatePropertyAll(BorderSide(color: _buttonBorder, width: 2)),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),
      inputDecorationTheme: const InputDecorationTheme(border: UnderlineInputBorder()),
      dividerTheme: DividerThemeData(space: 1, thickness: 1, color: scheme.outlineVariant),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }
}
