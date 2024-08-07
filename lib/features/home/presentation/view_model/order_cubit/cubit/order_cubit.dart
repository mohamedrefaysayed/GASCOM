import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:dinar_store/features/home/data/models/suppliers_model.dart';
import 'package:dinar_store/features/home/data/services/orders_services.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({required OrdersServices ordersServices}) : super(OrderInitial()) {
    _ordersServices = ordersServices;
  }

  late OrdersServices _ordersServices;

  static SuppliersModel? suppliersModel;

  static String payment = 'الدفع عند الاستلام';
  static TimeOfDay initialTime = TimeOfDay.now();
  static TimeOfDay? pickedTime;
  static LatLng? markerPosition;
  static String currentAddress = "أختر عنوان";
  static Marker? marker;

  static String? selectedValue;

  static OrdersModel? ordersModel;

  static OrdersModel? oldOrdersModel;

  static OrdersModel? agentOrdersModel;

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
        orders.orders = orders.orders!.reversed.toList();
        ordersModel = orders;
        emit(OrderSuccess(ordersModel: orders));
      },
    );
  }

  getAllOldOrders() async {
    oldOrdersModel == null ? emit(OldOrdersLoading()) : null;
    Either<ServerFailure, OrdersModel> result =
        await _ordersServices.getAllOldOrders(
      token: AppCubit.token!,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          OldOrdersFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (orders) async {
        orders.orders = orders.orders!.reversed.toList();
        oldOrdersModel = orders;
        emit(OldOrdersSuccess(ordersModel: orders));
      },
    );
  }

  storeOrder({
    required String userPhone,
    required String supplierPhone,
    required int tubsNumber,
    required int totalPrice,
  }) async {
    emit(AddToOrdersLoading());

    Either<ServerFailure, void> result = await _ordersServices.storeOrder(
      token: AppCubit.token!,
      userPhone: userPhone,
      supplierPhone: supplierPhone,
      tubsNumber: tubsNumber,
      totalPrice: totalPrice,
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

  cancelOrder({
    required String orderId,
  }) async {
    emit(CancelOrderLoading(orderId: orderId));

    Either<ServerFailure, void> result = await _ordersServices.cancelOrder(
      orderId: orderId,
      token: AppCubit.token!,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          CancelOrderFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (orders) async {
        emit(
          CancelOrderSuccess(),
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

  getSuppliers() async {
    emit(GetSuppliersLoading());
    Either<ServerFailure, SuppliersModel> result =
        await _ordersServices.getSuppliers(
      token: AppCubit.token!,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          GetSuppliersFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (suppliers) async {
        suppliersModel = suppliers;
        emit(GetSuppliersSuccess(suppliersModel: suppliers));
      },
    );
  }

  getAllAgentOrders() async {
    emit(GetagentsOrdersLoading());
    Either<ServerFailure, OrdersModel> result =
        await _ordersServices.getAllAgentOrders(
      token: AppCubit.token!,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          GetagentsOrdersFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (ordersmodel) async {
        agentOrdersModel = ordersmodel;
        emit(GetagentsOrdersSuccess(ordersModel: ordersmodel));
      },
    );
  }
}
