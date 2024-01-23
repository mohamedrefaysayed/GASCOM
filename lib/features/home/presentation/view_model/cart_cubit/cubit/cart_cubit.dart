import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/cart_items_model.dart';
import 'package:dinar_store/features/home/data/services/cart_services.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required CartServices cartServices}) : super(CartInitial()) {
    _cartServices = cartServices;
  }

  late CartServices _cartServices;

  static CartItemsModel cartItemsModel = CartItemsModel();

  static double totalPrice = 0;
  static double totalDiscount = 0;

  getAllItems() async {
    emit(GetCartLoading());
    Either<ServerFailure, CartItemsModel> result =
        await _cartServices.getAllItems(
      token: AppCubit.token!,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          GetCartFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (cartItems) async {
        for (var element in cartItems.cart!) {
          totalPrice = totalPrice +
              (double.parse(element.price!) * double.parse(element.quantity!));
        }
        cartItemsModel = cartItems;
        emit(GetCartSuccess(cartItemsModel: cartItems));
      },
    );
  }

  storeItem({
    required int productId,
    required int quantity,
    required int unitId,
    required double price,
  }) async {
    emit(AddToCartLoading());
    Either<ServerFailure, void> result = await _cartServices.storeItem(
      token: AppCubit.token!,
      productId: productId,
      quantity: quantity,
      unitId: unitId,
      price: price,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          AddToCartFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (categoriesModel) async {
        emit(AddToCartSuccess());
      },
    );
  }

  updateItem({
    required int productId,
    required int quantity,
    required int unitId,
    required double price,
  }) async {
    emit(UpdateItemLoading());
    Either<ServerFailure, void> result = await _cartServices.storeItem(
      token: AppCubit.token!,
      productId: productId,
      quantity: quantity,
      unitId: unitId,
      price: price,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          UpdateItemFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (categoriesModel) async {
        emit(UpdateItemSuccess());
      },
    );
  }

  deleteItem({
    required int itemId,
  }) async {
    emit(DeleteItemLoading());
    Either<ServerFailure, void> result = await _cartServices.deleteItem(
      token: AppCubit.token!,
      itemId: itemId,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          DeleteItemFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (categoriesModel) async {
        emit(DeleteItemSuccess());
      },
    );
  }
}
