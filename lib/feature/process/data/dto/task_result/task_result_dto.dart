import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark/feature/process/data/dto/path_result/path_result_dto.dart';

part 'task_result_dto.freezed.dart';
part 'task_result_dto.g.dart';

@freezed
abstract class TaskResultDto with _$TaskResultDto {
  const factory TaskResultDto({required String id, required PathResultDto result}) = _TaskResultDto;

  factory TaskResultDto.fromJson(Map<String, dynamic> json) => _$TaskResultDtoFromJson(json);
}
