import 'package:flutter/material.dart';
import 'package:webspark/core/theme/app_colors.dart';

extension ThemeContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colors => theme.colorScheme;

  AppColors get appColors => theme.extension<AppColors>() ?? AppColors.light;
}
