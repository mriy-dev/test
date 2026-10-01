import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:webspark/feature/home/data/response/tasks/tasks_response.dart';
import 'package:webspark/feature/process/data/dto/task_result/task_result_dto.dart';
import 'package:webspark/feature/process/data/response/results/results_response.dart';

part 'webspark_api.g.dart';

@RestApi()
abstract class WebsparkApi {
  factory WebsparkApi(Dio dio) = _WebsparkApi;

  @GET('/flutter/api')
  Future<TasksResponse> getTasks();

  @POST('/flutter/api')
  Future<ResultsResponse> sendResults(@Body() List<TaskResultDto> results);
}
