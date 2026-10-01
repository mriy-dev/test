import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'webspark_api.g.dart';

@RestApi()
abstract class WebsparkApi {
  factory WebsparkApi(Dio dio) = _WebsparkApi;

  @GET('/flutter/api')
  Future<dynamic> getTasks();

  @POST('/flutter/api')
  Future<dynamic> sendResults(@Body() dynamic results);
}
