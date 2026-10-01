import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark/feature/process/data/dto/point/point_dto.dart';

part 'path_result_dto.freezed.dart';
part 'path_result_dto.g.dart';

@freezed
abstract class PathResultDto with _$PathResultDto {
  const factory PathResultDto({required List<PointDto> steps, required String path}) =
      _PathResultDto;

  factory PathResultDto.fromJson(Map<String, dynamic> json) => _$PathResultDtoFromJson(json);
}
