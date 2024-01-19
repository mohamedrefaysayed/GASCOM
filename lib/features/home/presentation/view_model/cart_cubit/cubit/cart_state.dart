part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class AddToCartLoading extends CartState {}

final class GetCartLoading extends CartState {}

final class DeleteItemLoading extends CartState {}

final class UpdateItemLoading extends CartState {}

final class AddToCartSuccess extends CartState {}

final class DeleteItemSuccess extends CartState {}

final class UpdateItemSuccess extends CartState {}

final class GetCartSuccess extends CartState {
  CartItemsModel cartItemsModel;
  GetCartSuccess({required this.cartItemsModel});
}

final class AddToCartFailuer extends CartState {
  final String errMessage;
  AddToCartFailuer({required this.errMessage});
}

final class GetCartFailuer extends CartState {
  final String errMessage;
  GetCartFailuer({required this.errMessage});
}

final class DeleteItemFailuer extends CartState {
  final String errMessage;
  DeleteItemFailuer({required this.errMessage});
}

final class UpdateItemFailuer extends CartState {
  final String errMessage;
  UpdateItemFailuer({required this.errMessage});
}
