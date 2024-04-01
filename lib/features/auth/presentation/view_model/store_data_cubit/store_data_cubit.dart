import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/auth/data/models/model/register_model.dart';
import 'package:dinar_store/features/auth/data/services/log_in_services.dart';
import 'package:dinar_store/features/auth/presentation/view_model/location_cubit/cubit/location_cubit.dart';
import 'package:dinar_store/features/auth/presentation/view_model/log_in_cubit/log_in_cubit.dart';
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

  Future<void> storeData() async {
    emit(StoreDataLoading());

    Either<ServerFailure, RegisterModel> result = await _logInServices.register(
      position: LocationCubit.currentPosition!,
      name: nameController.text,
      phoneNumber: LogInCubit.phoneNumber!.completeNumber,
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

        if (data.token != null) {
          _logInServices.storeTokenInSecureStorage(token: data.token!);
        }

        LocationCubit.currentPosition == null;
      },
    );
  }
}
