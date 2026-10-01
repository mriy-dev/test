import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark/feature/home/data/response/point/point_response.dart';

part 'task_response.freezed.dart';
part 'task_response.g.dart';

@freezed
abstract class TaskResponse with _$TaskResponse {
  const factory TaskResponse({
    required String id,
    @Default(<String>[]) List<String> field,
    required PointResponse start,
    required PointResponse end,
  }) = _TaskResponse;

  factory TaskResponse.fromJson(Map<String, dynamic> json) => _$TaskResponseFromJson(json);
}
