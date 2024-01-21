import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/auth/data/services/log_in_services.dart';
import 'package:dinar_store/features/auth/presentation/view_model/location_cubit/cubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'store_data_state.dart';

class StoreDataCubit extends Cubit<StoreDataState> {
  StoreDataCubit({
    required LogInServices logInServices,
  }) : super(StoreDataInitial()) {
    _logInServices = logInServices;
  }

  late LogInServices _logInServices;

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static TextEditingController nameController = TextEditingController();
  static TextEditingController marketNameController = TextEditingController();
  static TextEditingController govController = TextEditingController();
  static TextEditingController addressController = TextEditingController();
  static TextEditingController marketPhoneController = TextEditingController();

  Future<void> storeData() async {
    emit(StoreDataLoading());

    Either<ServerFailure, void> result = await _logInServices.storeData(
      ownerName: nameController.text,
      storeName: marketNameController.text,
      district: govController.text,
      address: addressController.text,
      phone: marketPhoneController.text,
      position: LocationCubit.currentPosition!,
      token: AppCubit.token!,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          StoreDataFailure(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (data) async {
        emit(StoreDataSuccess());
        nameController.clear();
        marketNameController.clear();
        govController.clear();
        addressController.clear();
        marketPhoneController.clear();
        LocationCubit.currentPosition == null;
      },
    );
  }
}
