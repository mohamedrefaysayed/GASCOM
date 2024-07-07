import 'package:dartz/dartz.dart';
import 'package:dinar_store/features/home/data/services/location_service.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/helpers/app_cache/cahch_helper.dart';
import 'package:dinar_store/core/utils/genrall.dart';
import 'package:dinar_store/features/auth/data/models/model/login_model.dart';
import 'package:dinar_store/features/auth/data/models/model/register_model.dart';
import 'package:dinar_store/features/auth/data/models/model/verfiy_model.dart';
import 'package:dinar_store/features/auth/data/services/log_in_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:map_location_picker/map_location_picker.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit({
    required LogInServices logInServices,
    required LocationServices locationServices,
  }) : super(LogInInitial()) {
    _logInServices = logInServices;
    _locationServices = locationServices;
  }

  late LogInServices _logInServices;
  late LocationServices _locationServices;

  static PhoneNumber? phoneNumber;
  static String? code;
  static String? fakeCode;
  static String? name;

  static bool isExist = false;

  Future<void> login() async {
    emit(SendCodeLoading());

    Either<ServerFailure, LoginModel> result = await _logInServices.logIn(
      phoneNumber: phoneNumber!.completeNumber.trim().replaceAll('+', ""),
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          LogInFailure(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (data) async {
        fakeCode = data.otp;
        isExist = data.exists ?? false;
        CacheHelper.saveData(
            key: "userPhone",
            value: phoneNumber!.completeNumber.trim().replaceAll('+', ""));
        userPhone = phoneNumber!.completeNumber;
        emit(
          SendCodeSuccess(
            message: data.exists.toString(),
          ),
        );
      },
    );
  }

  Future<void> register() async {
    emit(SendCodeLoading());

    Either<ServerFailure, Position> result =
        await _locationServices.getLocation();

    result.fold(
      //error
      (serverFailure) {
        emit(
          LogInFailure(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (postion) async {
        Either<ServerFailure, RegisterModel> result =
            await _logInServices.register(
          phoneNumber: phoneNumber!.completeNumber,
          name: name!,
          position: postion,
        );

        result.fold(
          //error
          (serverFailure) {
            emit(
              LogInFailure(errMessage: serverFailure.errMessage),
            );
          },
          //success
          (data) async {
            await _logInServices.storeTokenInSecureStorage(token: data.token!);

            emit(SendCodeSuccess(message: data.created.toString()));
          },
        );
      },
    );
  }

  Future<void> sendVerficationCode() async {
    emit(VerficationLoading());
    Either<ServerFailure, VerfiyModel> result = await _logInServices.verify(
      otp: code!,
      phoneNumber: phoneNumber!.completeNumber.trim().replaceAll('+', ""),
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          LogInFailure(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (data) async {
        if (data.token != null) {
          await _logInServices.storeTokenInSecureStorage(token: data.token!);
        }

        emit(VerficationSuccess());
      },
    );
  }
}
