import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/utils/genrall.dart';
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
      phone: userPhone!,
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
}
