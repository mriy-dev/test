import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_check_response.freezed.dart';
part 'result_check_response.g.dart';

@freezed
abstract class ResultCheckResponse with _$ResultCheckResponse {
  const factory ResultCheckResponse({required String id, @Default(false) bool correct}) =
      _ResultCheckResponse;

  factory ResultCheckResponse.fromJson(Map<String, dynamic> json) =>
      _$ResultCheckResponseFromJson(json);
}
