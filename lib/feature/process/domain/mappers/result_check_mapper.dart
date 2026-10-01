import 'package:webspark/feature/process/data/response/result_check/result_check_response.dart';
import 'package:webspark/feature/process/data/response/results/results_response.dart';
import 'package:webspark/feature/process/domain/models/result_check_model.dart';

extension ResultsResponseMapper on ResultsResponse {
  List<ResultCheckModel> toDomain() =>
      data.map((check) => check.toDomain()).toList(growable: false);
}

extension ResultCheckResponseMapper on ResultCheckResponse {
  ResultCheckModel toDomain() => ResultCheckModel(id: id, correct: correct);
}
