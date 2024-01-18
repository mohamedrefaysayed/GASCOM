part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {}

final class CartFailuer extends CartState {
  final String errMessage;
  CartFailuer({required this.errMessage});
}
