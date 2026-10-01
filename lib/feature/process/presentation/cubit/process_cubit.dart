import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark/feature/home/domain/models/task_model.dart';
import 'package:webspark/feature/process/domain/models/result_check_model.dart';
import 'package:webspark/feature/process/domain/models/task_result_model.dart';

part 'process_cubit.freezed.dart';

abstract class ProcessCubit extends Cubit<ProcessState> {
  ProcessCubit(super.initialState);

  Future<void> findPaths(List<TaskModel> tasks);

  Future<void> send();
}

@freezed
sealed class ProcessState with _$ProcessState {
  const factory ProcessState.initial() = ProcessInitial;

  const factory ProcessState.busy({
    @Default(<TaskResultModel>[]) List<TaskResultModel> results,
    @Default(0) int progress,
  }) = ProcessBusy;

  const factory ProcessState.failure({
    required String message,
    required List<TaskResultModel> results,
  }) = ProcessFailure;

  const factory ProcessState.success({
    required List<TaskResultModel> results,
    List<ResultCheckModel>? checks,
  }) = ProcessSuccess;
}

extension ProcessStateX on ProcessState {
  List<TaskResultModel> get results => switch (this) {
    ProcessBusy(:final results) => results,
    ProcessFailure(:final results) => results,
    ProcessSuccess(:final results) => results,
    ProcessInitial() => const [],
  };

  bool get hasResults => results.isNotEmpty;

  bool get canShowAction => this is! ProcessBusy && this is! ProcessInitial;

  bool get isCalculating => this is ProcessBusy && !hasResults;

  bool get isSending => this is ProcessBusy && hasResults;

  bool get isBusy => isSending;

  int get progress => switch (this) {
    ProcessBusy(:final progress) => progress,
    ProcessInitial() => 0,
    _ => 100,
  };

  bool get canSend => hasResults && (this is ProcessSuccess || this is ProcessFailure);

  String? get errorMessage => switch (this) {
    ProcessFailure(:final message) => message,
    _ => null,
  };
}
