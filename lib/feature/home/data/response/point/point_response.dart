import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_response.freezed.dart';
part 'point_response.g.dart';

@freezed
abstract class PointResponse with _$PointResponse {
  const factory PointResponse({required int x, required int y}) = _PointResponse;

  factory PointResponse.fromJson(Map<String, dynamic> json) => _$PointResponseFromJson(json);
}
