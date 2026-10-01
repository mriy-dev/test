import 'package:flutter/material.dart';
import 'package:webspark/core/extensions/task_result_extension.dart';
import 'package:webspark/feature/preview/presentation/preview_screen.dart';
import 'package:webspark/feature/process/domain/models/task_result_model.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key, required this.results});

  final List<TaskResultModel> results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result list screen')),
      body: ListView.separated(
        itemCount: results.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final result = results[index];

          return ListTile(
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute<void>(builder: (_) => PreviewScreen(result: result))),
            title: Text(result.displayPath, textAlign: TextAlign.center),
          );
        },
      ),
    );
  }
}
