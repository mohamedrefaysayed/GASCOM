import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/utils/genrall.dart';
import 'package:dinar_store/features/auth/data/models/model/register_model.dart';
import 'package:dinar_store/features/auth/data/services/log_in_services.dart';
import 'package:dinar_store/features/auth/presentation/view_model/location_cubit/cubit/location_cubit.dart';
import 'package:dinar_store/features/auth/presentation/view_model/log_in_cubit/log_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/map_location_picker.dart';

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

  static TextEditingController agentNumberController = TextEditingController();

  static TextEditingController priceController = TextEditingController();

  static ValueNotifier<File?> img = ValueNotifier(null);

  Future<void> storeData() async {
    emit(StoreDataLoading());

    Either<ServerFailure, RegisterModel> result = isCustomer
        ? await _logInServices.register(
            position: LocationCubit.currentPosition!,
            name: nameController.text,
            phoneNumber: LogInCubit.phoneNumber!.completeNumber
                .trim()
                .replaceAll('+', ""),
          )
        : await _logInServices.registerAgent(
            position: LocationCubit.currentPosition!,
            name: nameController.text,
            phoneNumber: LogInCubit.phoneNumber!.completeNumber
                .trim()
                .replaceAll('+', ""),
            agentNumber: agentNumberController.text,
            price: priceController.text,
            img: img.value!,
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

  Future<void> updateData({
    String? name,
    LatLng? position,
  }) async {
    emit(UpdateDataLoading());

    Either<ServerFailure, RegisterModel> result = isCustomer
        ? await _logInServices.updateData(
            position: position,
            name: name,
          )
        : await _logInServices.updateDataAgent(
            position: position,
            name: name,
            img: img.value,
          );

    result.fold(
      //error
      (serverFailure) {
        emit(
          UpdateDataFailure(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (data) async {
        emit(UpdateDataSuccess());
        nameController.clear();

        if (data.token != null) {
          _logInServices.storeTokenInSecureStorage(token: data.token!);
        }
      },
    );
  }

  Future getImage({required ImageSource media}) async {
    XFile? selected = await ImagePicker().pickImage(source: media);
    if (selected != null) {
      img.value = File(selected.path);
      await cropImage(imagefile: selected);
    }
  }

  Future cropImage({required XFile imagefile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imagefile.path, uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Edit Photo',
          backgroundColor: Colors.grey.withOpacity(0.5),
          activeControlsWidgetColor: Colors.blue,
          cropFrameColor: Colors.blue,
          cropGridColor: Colors.blue,
          toolbarColor: Colors.grey.withOpacity(0.5),
          toolbarWidgetColor: Colors.blue,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    ]);
    if (croppedImage == null) return null;
    img.value = File(croppedImage.path);
  }
}
