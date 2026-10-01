import 'package:fpdart/fpdart.dart';
import 'package:webspark/core/api/base/exception/app_exception.dart';
import 'package:webspark/feature/home/domain/models/task_model.dart';

abstract class HomeRepo {
  String? get savedUrl;

  Future<AppEither<None>> setUrl(String url);

  Future<AppEither<List<TaskModel>>> getTasks();
}
