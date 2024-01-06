part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationSuccess extends LocationState {}

final class LocationFailuer extends LocationState {}
