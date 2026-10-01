import 'package:flutter/material.dart';
import 'package:webspark/core/extensions/task_result_extension.dart';
import 'package:webspark/core/extensions/theme_extension.dart';
import 'package:webspark/feature/preview/presentation/widgets/path_grid.dart';
import 'package:webspark/feature/process/domain/models/task_result_model.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, required this.result});

  final TaskResultModel result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview screen')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PathGrid(result: result),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                result.displayPath,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
