import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:dinar_store/features/home/data/models/send_order_model.dart';
import 'package:dinar_store/features/home/data/services/orders_services.dart';
import 'package:dinar_store/features/home/presentation/view_model/cart_cubit/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({required OrdersServices ordersServices}) : super(OrderInitial()) {
    _ordersServices = ordersServices;
  }

  late OrdersServices _ordersServices;

  static String payment = 'الدفع عند الاستلام';
  static TimeOfDay initialTime = TimeOfDay.now();
  static TimeOfDay? pickedTime;
  static LatLng? markerPosition;
  static String currentAddress = "أختر عنوان";
  static Marker? marker;

  static OrdersModel? ordersModel;

  getAllOrders() async {
    ordersModel == null ? emit(OrderLoading()) : null;
    Either<ServerFailure, OrdersModel> result =
        await _ordersServices.getAllOrders(
      token: AppCubit.token!,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          OrderFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (orders) async {
        ordersModel = orders;
        emit(OrderSuccess(ordersModel: orders));
      },
    );
  }

  storeOrder({
    required int status,
    required double discount,
    required double tax,
    required double price,
    required int addressId,
  }) async {
    emit(AddToOrdersLoading());

    SendOrderModel sendOrderModel = SendOrderModel();

    List<Map<String, dynamic>> orderDetails = [];

    for (var cartItem in CartCubit.cartItemsModel!.cart!) {
      orderDetails.add(
        SendOrderDetails(
          productId: int.parse(cartItem.productId!),
          unitId: double.parse(cartItem.unitId!).toInt(),
          qty: double.parse(cartItem.quantity!).toInt(),
          price: double.parse(cartItem.price!).toInt(),
        ).toJson(),
      );
    }
    sendOrderModel = SendOrderModel.fromJson({
      'status': status,
      'discount': discount.toInt(),
      'tax': tax.toInt(),
      'address_id': addressId,
      'order_details': orderDetails,
    });

    Either<ServerFailure, void> result = await _ordersServices.storeOrder(
      token: AppCubit.token!,
      status: status,
      discount: discount,
      tax: tax,
      addressId: addressId,
      sendOrderModel: sendOrderModel,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          AddOrderFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (orders) async {
        emit(
          AddOrderSuccess(),
        );
      },
    );
  }

  void addMarker(LatLng position) async {
    markerPosition = position;
    const markerId = MarkerId('marker_id');
    marker = Marker(
      markerId: markerId,
      position: position,
    );
    emit(OrderInitial());

    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress = '${place.street}';
      emit(OrderInitial());
    });
  }
}
