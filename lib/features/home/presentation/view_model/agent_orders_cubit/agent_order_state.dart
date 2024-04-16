part of 'agent_order_cubit.dart';

sealed class AgentOrderState {}

final class OrderInitial extends AgentOrderState {}

final class OrderLoading extends AgentOrderState {}

final class AddToOrdersLoading extends AgentOrderState {}

final class DeleteOrderLoading extends AgentOrderState {}

final class OrderSuccess extends AgentOrderState {
  final OrdersModel ordersModel;
  OrderSuccess({required this.ordersModel});
}

final class AddOrderSuccess extends AgentOrderState {}

final class DeleteOrderSuccess extends AgentOrderState {
  final OrdersModel ordersModel;
  DeleteOrderSuccess({required this.ordersModel});
}

final class AddOrderFailuer extends AgentOrderState {
  final String errMessage;
  AddOrderFailuer({required this.errMessage});
}

final class OrderFailuer extends AgentOrderState {
  final String errMessage;
  OrderFailuer({required this.errMessage});
}

final class DeleteOrderFailuer extends AgentOrderState {
  final String errMessage;
  DeleteOrderFailuer({required this.errMessage});
}

final class GetSuppliersLoading extends AgentOrderState {}

final class GetSuppliersSuccess extends AgentOrderState {
  SuppliersModel suppliersModel;
  GetSuppliersSuccess({
    required this.suppliersModel,
  });
}

final class GetSuppliersFailuer extends AgentOrderState {
  final String errMessage;
  GetSuppliersFailuer({required this.errMessage});
}

final class GetagentsOrdersLoading extends AgentOrderState {}

final class GetagentsOrdersSuccess extends AgentOrderState {
  OrdersModel ordersModel;
  GetagentsOrdersSuccess({
    required this.ordersModel,
  });
}

final class GetagentsOrdersFailuer extends AgentOrderState {
  final String errMessage;
  GetagentsOrdersFailuer({required this.errMessage});
}

final class ApproveOrderLoading extends AgentOrderState {
  final String orderId;
  ApproveOrderLoading({required this.orderId});
}

final class ApproveOrderSuccess extends AgentOrderState {}

final class ApproveOrdersFailuer extends AgentOrderState {
  final String errMessage;
  ApproveOrdersFailuer({required this.errMessage});
}

final class RejectOrderLoading extends AgentOrderState {
  final String orderId;
  RejectOrderLoading({required this.orderId});
}

final class RejectOrderSuccess extends AgentOrderState {}

final class RejectOrderFailuer extends AgentOrderState {
  final String errMessage;
  RejectOrderFailuer({required this.errMessage});
}

final class ChangePriceLoading extends AgentOrderState {}

final class ChangePriceSuccess extends AgentOrderState {}

final class ChangePriceFailuer extends AgentOrderState {
  final String errMessage;
  ChangePriceFailuer({required this.errMessage});
}
