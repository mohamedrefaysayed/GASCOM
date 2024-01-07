part of 'ads_cubit.dart';

sealed class AdsState {}

final class AdsInitial extends AdsState {}

final class AdsLoading extends AdsState {}

final class AdsSuccess extends AdsState {
  final AdsModel adsModel;
  AdsSuccess({required this.adsModel});
}

final class AdsFaliuer extends AdsState {
  final String errMessage;
  AdsFaliuer({required this.errMessage});
}
