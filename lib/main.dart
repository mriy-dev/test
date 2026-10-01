import 'package:flutter/material.dart';
import 'package:webspark/boot/boot.dart';
import 'package:webspark/core/env/env.dart';
import 'package:webspark/feature/home/presentation/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initEnv();
  await configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: HomeScreen()));
  }
}
