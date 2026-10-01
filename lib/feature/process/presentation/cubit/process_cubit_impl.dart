import 'package:injectable/injectable.dart';
import 'package:webspark/feature/home/domain/models/task_model.dart';
import 'package:webspark/feature/process/domain/models/task_result_model.dart';
import 'package:webspark/feature/process/domain/repo/process_repo.dart';
import 'package:webspark/feature/process/domain/services/path_finding/path_finder.dart';
import 'package:webspark/feature/process/domain/services/progress_tracker.dart';
import 'package:webspark/feature/process/presentation/cubit/process_cubit.dart';

@Injectable(as: ProcessCubit)
class ProcessCubitImpl extends ProcessCubit {
  final ProcessRepo _repo;
  final PathFinder _pathFinder;

  ProcessCubitImpl(this._repo, this._pathFinder) : super(const ProcessState.initial());

  static const _frame = Duration(milliseconds: 16);

  @override
  Future<void> findPaths(List<TaskModel> tasks) async {
    final progress = ProgressTracker(tasks);
    final results = <TaskResultModel>[];

    emit(const ProcessState.busy());

    for (final task in tasks) {
      final steps = await _pathFinder.find(
        task,
        onVisit: (visited) async {
          await Future<void>.delayed(_frame);
          emit(ProcessState.busy(progress: progress.visiting(visited)));
        },
      );

      results.add(TaskResultModel(task: task, steps: steps));
      emit(ProcessState.busy(progress: progress.completed(task)));
    }

    emit(ProcessState.success(results: List.unmodifiable(results)));
  }

  @override
  Future<void> send() async {
    final results = state.results;
    if (!state.canSend) return;

    emit(ProcessState.busy(results: results, progress: 100));

    final response = await _repo.sendResults(results);
    if (isClosed) return;

    response.fold(
      (fail) => emit(ProcessState.failure(message: fail.message, results: results)),
      (checks) => emit(ProcessState.success(results: results, checks: checks)),
    );
  }
}
