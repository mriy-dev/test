import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_check_model.freezed.dart';

@freezed
abstract class ResultCheckModel with _$ResultCheckModel {
  const factory ResultCheckModel({required String id, required bool correct}) = _ResultCheckModel;
}
