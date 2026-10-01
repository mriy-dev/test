import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark/feature/process/data/response/result_check/result_check_response.dart';

part 'results_response.freezed.dart';
part 'results_response.g.dart';

@freezed
abstract class ResultsResponse with _$ResultsResponse {
  const factory ResultsResponse({
    @Default(false) bool error,
    @Default('') String message,
    @Default(<ResultCheckResponse>[]) List<ResultCheckResponse> data,
  }) = _ResultsResponse;

  factory ResultsResponse.fromJson(Map<String, dynamic> json) => _$ResultsResponseFromJson(json);
}
