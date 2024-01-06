import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/auth/data/services/log_in_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit({
    required LogInServices logInServices,
  }) : super(LogInInitial()) {
    _logInServices = logInServices;
  }

  late LogInServices _logInServices;

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static TextEditingController nameController = TextEditingController();
  static TextEditingController marketNameController = TextEditingController();
  static TextEditingController govController = TextEditingController();
  static TextEditingController addressController = TextEditingController();
  static TextEditingController marketPhoneController = TextEditingController();

  static PhoneNumber? phoneNumber;
  static String? code;

  Future<void> logIn() async {
    emit(SendCodeLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(SendCodeSuccess());
    // Either<ServerFailure, String> result =
    //     await _logInServices.logIn(email: " email!", password: "password!");

    // result.fold(
    //   //error
    //   (serverFailure) {
    //     emit(
    //       LogInFailure(errMessage: serverFailure.errMessage),
    //     );
    //   },
    //   //success
    //   (data) async {
    //     await _logInServices.storeTokenInSecureStorage(token: "data.token");

    //     emit(SendCodeSuccess());
    //   },
    // );
  }

  Future<void> sendVerficationCode() async {
    emit(SendPhoneLoading());
    Either<ServerFailure, String> result =
        await _logInServices.logIn(email: "email!", password: "password!");

    result.fold(
      //error
      (serverFailure) {
        emit(
          LogInFailure(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (data) async {
        await _logInServices.storeTokenInSecureStorage(token: "data.token");

        emit(SendPhoneSuccess());
      },
    );
  }
}
