import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_cubit.freezed.dart';

abstract class HomeCubit extends Cubit<HomeState> {
  HomeCubit(super.initialState);

  Future<void> setBaseUrl({required String url});
}

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.busy({String? baseUrl}) = _Busy;
  const factory HomeState.failure({required String message, String? baseUrl}) = _Failure;
  const factory HomeState.success({required String baseUrl}) = _Success;
}
