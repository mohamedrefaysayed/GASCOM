part of 'store_data_cubit.dart';

sealed class StoreDataState {}

final class StoreDataInitial extends StoreDataState {}

final class StoreDataLoading extends StoreDataState {}

final class SetImgLoading extends StoreDataState {}

final class UpdateDataLoading extends StoreDataState {}

final class StoreDataSuccess extends StoreDataState {}

final class UpdateDataSuccess extends StoreDataState {}

final class SetImgSuccess extends StoreDataState {}

final class StoreDataFailure extends StoreDataState {
  final String errMessage;

  StoreDataFailure({required this.errMessage});
}

final class UpdateDataFailure extends StoreDataState {
  final String errMessage;

  UpdateDataFailure({required this.errMessage});
}

final class SetImgsaFailure extends StoreDataState {}
