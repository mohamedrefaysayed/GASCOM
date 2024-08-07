part of 'order_cubit.dart';

sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class AddToOrdersLoading extends OrderState {}

final class DeleteOrderLoading extends OrderState {}

final class OldOrdersLoading extends OrderState {}

final class OldOrdersFailuer extends OrderState {
  final String errMessage;
  OldOrdersFailuer({required this.errMessage});
}

final class OldOrdersSuccess extends OrderState {
  final OrdersModel ordersModel;
  OldOrdersSuccess({required this.ordersModel});
}

final class OrderSuccess extends OrderState {
  final OrdersModel ordersModel;
  OrderSuccess({required this.ordersModel});
}

final class AddOrderSuccess extends OrderState {}

final class DeleteOrderSuccess extends OrderState {
  final OrdersModel ordersModel;
  DeleteOrderSuccess({required this.ordersModel});
}

final class AddOrderFailuer extends OrderState {
  final String errMessage;
  AddOrderFailuer({required this.errMessage});
}

final class OrderFailuer extends OrderState {
  final String errMessage;
  OrderFailuer({required this.errMessage});
}

final class DeleteOrderFailuer extends OrderState {
  final String errMessage;
  DeleteOrderFailuer({required this.errMessage});
}

final class GetSuppliersLoading extends OrderState {}

final class GetSuppliersSuccess extends OrderState {
  SuppliersModel suppliersModel;
  GetSuppliersSuccess({
    required this.suppliersModel,
  });
}

final class GetSuppliersFailuer extends OrderState {
  final String errMessage;
  GetSuppliersFailuer({required this.errMessage});
}

final class GetagentsOrdersLoading extends OrderState {}

final class GetagentsOrdersSuccess extends OrderState {
  OrdersModel ordersModel;
  GetagentsOrdersSuccess({
    required this.ordersModel,
  });
}

final class GetagentsOrdersFailuer extends OrderState {
  final String errMessage;
  GetagentsOrdersFailuer({required this.errMessage});
}

final class CancelOrderLoading extends OrderState {
  final String orderId;
  CancelOrderLoading({required this.orderId});
}

final class CancelOrderSuccess extends OrderState {}

final class CancelOrderFailuer extends OrderState {
  final String errMessage;
  CancelOrderFailuer({required this.errMessage});
}
