part of 'agent_order_actions_cubit.dart';

sealed class AgentOrderActionsState {}

final class OrderInitial extends AgentOrderActionsState {}

final class ApproveOrderActionsLoading extends AgentOrderActionsState {
  final String orderId;
  ApproveOrderActionsLoading({required this.orderId});
}

final class ApproveOrderActionsSuccess extends AgentOrderActionsState {}

final class ApproveOrdersActionsFailuer extends AgentOrderActionsState {
  final String errMessage;
  ApproveOrdersActionsFailuer({required this.errMessage});
}

final class RejectOrderActionsLoading extends AgentOrderActionsState {
  final String orderId;
  RejectOrderActionsLoading({required this.orderId});
}

final class RejectOrderActionsSuccess extends AgentOrderActionsState {}

final class RejectOrderActionsFailuer extends AgentOrderActionsState {
  final String errMessage;
  RejectOrderActionsFailuer({required this.errMessage});
}

final class DeleverOrderActionsLoading extends AgentOrderActionsState {}

final class DeleverOrderActionsSuccess extends AgentOrderActionsState {}

final class DeleverOrderActionsFailuer extends AgentOrderActionsState {
  final String errMessage;
  DeleverOrderActionsFailuer({required this.errMessage});
}
