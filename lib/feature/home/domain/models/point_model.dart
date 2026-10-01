import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_model.freezed.dart';

@freezed
abstract class PointModel with _$PointModel {
  const factory PointModel({required int x, required int y}) = _PointModel;
}
