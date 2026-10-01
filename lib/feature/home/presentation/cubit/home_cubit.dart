import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webspark/feature/home/domain/models/task_model.dart';

part 'home_cubit.freezed.dart';

abstract class HomeCubit extends Cubit<HomeState> {
  HomeCubit(super.initialState);

  Future<void> setBaseUrl({required String url});
}

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.initial({String? baseUrl}) = HomeInitial;
  const factory HomeState.busy({String? baseUrl}) = HomeBusy;
  const factory HomeState.failure({required String message, String? baseUrl}) = HomeFailure;
  const factory HomeState.success({required String baseUrl, required List<TaskModel> tasks}) =
      HomeSuccess;
}

extension HomeStateX on HomeState {
  bool get isBusy => this is HomeBusy;

  String? get baseUrl => switch (this) {
    HomeInitial(:final baseUrl) => baseUrl,
    HomeBusy(:final baseUrl) => baseUrl,
    HomeFailure(:final baseUrl) => baseUrl,
    HomeSuccess(:final baseUrl) => baseUrl,
  };
}
