import 'package:injectable/injectable.dart';
import 'package:webspark/feature/home/domain/repo/home_repo.dart';
import 'package:webspark/feature/home/presentation/cubit/home_cubit.dart';

@Injectable(as: HomeCubit)
class HomeCubitImpl extends HomeCubit {
  final HomeRepo _repo;

  HomeCubitImpl(this._repo) : super(HomeState.initial(baseUrl: _repo.savedUrl));

  @override
  Future<void> setBaseUrl({required String url}) async {
    emit(HomeState.busy(baseUrl: url));

    final saved = await _repo.setUrl(url);

    final failed = saved.fold((fail) {
      emit(HomeState.failure(message: fail.message, baseUrl: url));
      return true;
    }, (_) => false);
    if (failed) return;

    final loaded = await _repo.getTasks();

    loaded.fold(
      (fail) => emit(HomeState.failure(message: fail.message, baseUrl: url)),
      (tasks) => emit(HomeState.success(baseUrl: url, tasks: tasks)),
    );
  }
}
