part of 'log_in_agent_cubit.dart';

@immutable
sealed class LogInAgentState {}

final class LogInInitial extends LogInAgentState {}

final class SendCodeLoading extends LogInAgentState {}

final class VerficationLoading extends LogInAgentState {}

final class SendCodeSuccess extends LogInAgentState {
  final String message;
  SendCodeSuccess({required this.message});
}

final class VerficationSuccess extends LogInAgentState {}

final class LogInFailure extends LogInAgentState {
  final String errMessage;

  LogInFailure({required this.errMessage});
}
