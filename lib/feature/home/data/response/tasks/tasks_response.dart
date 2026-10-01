import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark/feature/home/data/response/task/task_response.dart';

part 'tasks_response.freezed.dart';
part 'tasks_response.g.dart';

@freezed
abstract class TasksResponse with _$TasksResponse {
  const factory TasksResponse({
    @Default(false) bool error,
    @Default('') String message,
    @Default(<TaskResponse>[]) List<TaskResponse> data,
  }) = _TasksResponse;

  factory TasksResponse.fromJson(Map<String, dynamic> json) => _$TasksResponseFromJson(json);
}
