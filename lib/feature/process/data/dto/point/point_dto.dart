import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_dto.freezed.dart';
part 'point_dto.g.dart';

@freezed
abstract class PointDto with _$PointDto {
  const factory PointDto({required int x, required int y}) = _PointDto;

  factory PointDto.fromJson(Map<String, dynamic> json) => _$PointDtoFromJson(json);
}
