part of 'store_data_cubit.dart';

sealed class StoreDataState {}

final class StoreDataInitial extends StoreDataState {}

final class StoreDataLoading extends StoreDataState {}

final class StoreDataSuccess extends StoreDataState {}

final class StoreDataFailure extends StoreDataState {
  final String errMessage;

  StoreDataFailure({required this.errMessage});
}
