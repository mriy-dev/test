import 'package:webspark/feature/process/presentation/cubit/process_cubit.dart';

extension ProcessStateTextX on ProcessState {
  String get statusText {
    if (isCalculating) return 'Calculating shortest paths...';
    if (isSending) return 'Sending results to server...';

    return 'All calculations has finished, you can send your results to server';
  }
}
