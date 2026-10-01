import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:webspark/core/api/base/exception/app_exception.dart';
import 'package:webspark/feature/home/data/gateway/base_url_gateway.dart';
import 'package:webspark/feature/home/data/gateway/tasks_gateway.dart';
import 'package:webspark/feature/home/domain/mappers/task_mapper.dart';
import 'package:webspark/feature/home/domain/models/task_model.dart';
import 'package:webspark/feature/home/domain/repo/home_repo.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl extends HomeRepo {
  final BaseUrlGateway _urlGateway;
  final TasksGateway _tasksGateway;

  HomeRepoImpl(this._urlGateway, this._tasksGateway);

  @override
  String? get savedUrl => _urlGateway.savedUrl;

  @override
  Future<AppEither<None>> setUrl(String url) => _urlGateway.setUrl(url.trim());

  @override
  Future<AppEither<List<TaskModel>>> getTasks() async {
    final result = await _tasksGateway.getTasks();

    return result.fold(Left.new, (response) {
      if (response.error) {
        return Left(AppException(message: response.message, response: response.toJson()));
      }

      final tasks = response.toDomain();
      if (tasks.isEmpty) {
        return const Left(AppException(message: 'No tasks received, check the URL'));
      }

      return Right(tasks);
    });
  }
}
