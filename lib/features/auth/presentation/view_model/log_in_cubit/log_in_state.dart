part of 'log_in_cubit.dart';

@immutable
sealed class LogInState {}

final class LogInInitial extends LogInState {}

final class SendCodeLoading extends LogInState {}

final class SendPhoneLoading extends LogInState {}

final class SendCodeSuccess extends LogInState {}

final class SendPhoneSuccess extends LogInState {}

final class LogInFailure extends LogInState {
  final String errMessage;

  LogInFailure({required this.errMessage});
}
