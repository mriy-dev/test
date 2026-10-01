import 'package:webspark/feature/home/presentation/cubit/home_cubit.dart';

class HomeCubitImpl extends HomeCubit {
  HomeCubitImpl() : super(const HomeState.initial());

  @override
  Future<void> setBaseUrl({required String url}) {
    // TODO: implement setBaseUrl
    throw UnimplementedError();
  }
}
