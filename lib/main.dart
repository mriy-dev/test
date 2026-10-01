import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:webspark/boot/boot.dart';
import 'package:webspark/core/theme/app_theme.dart';
import 'package:webspark/core/validators/app_reactive_validators.dart';
import 'package:webspark/feature/home/presentation/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConfig(
      validationMessages: AppValidationMessages.defaults,
      child: MaterialApp(theme: AppTheme.light(), home: const HomeScreen()),
    );
  }
}
