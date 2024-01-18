import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/services/cart_services.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required CartServices cartServices}) : super(CartInitial()) {
    _cartServices = cartServices;
  }

  late CartServices _cartServices;

  storeItem({
    required int productId,
    required int quantity,
    required int unitId,
    required double price,
  }) async {
    emit(CartLoading());
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
          CartFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (categoriesModel) async {
        emit(CartSuccess());
      },
    );
  }
}
