// ignore_for_file: use_build_context_synchronously

import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/features/home/data/services/location_service.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required LocationServices locationServices})
      : super(LocationInitial()) {
    _locationServices = locationServices;
  }
  late LocationServices _locationServices;

  static Position? currentPosition;

  static Placemark? address;

  Future getCurrentLocation({required BuildContext context}) async {
    try {
      emit(LocationLoading());
      bool locationsIsGranted = await Permission.location.status.isGranted;
      if (!locationsIsGranted) {
        locationsIsGranted = await Permission.location.request().isDenied;
      } else {
        bool locationsIsGranted =
            await Permission.locationAlways.status.isGranted;
        if (!locationsIsGranted) {
          locationsIsGranted =
              await Permission.locationAlways.request().isGranted;
        }
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.

      currentPosition = await Geolocator.getCurrentPosition();

      if (AppCubit.token != null) {
        await _locationServices.updateUserLocation(
            token: AppCubit.token!, position: currentPosition!);
      }

      Either<ServerFailure, Placemark> result =
          await _locationServices.convertPositionToAddress(
        lat: currentPosition!.latitude,
        lng: currentPosition!.longitude,
      );
      result.fold(
          //error
          (error) => emit(LocationFailuer()),
          //success
          (newAddress) {
        address = newAddress;

        emit(LocationSuccess(position: currentPosition!, address: newAddress));
      });
    } catch (error) {
      emit(LocationFailuer());
      ScaffoldMessenger.of(context).showSnackBar(
        messageSnackBar(message: "أفتح الموقع"),
      );
    }
  }

  Future<void> getAddress(double lat, double lng) async {
    emit(LocationLoading());

    Either<ServerFailure, Placemark> addressResult =
        await _locationServices.convertPositionToAddress(lat: lat, lng: lng);

    addressResult.fold(
      //error
      (serverFailure) {
        print(serverFailure.errMessage);
        emit(
          AddressFailuer(errorMessage: serverFailure.errMessage),
        );
      },
      //success
      (newAddress) {
        emit(
          AddressSuccess(
            locationData: {
              'lat': lat,
              'lng': lng,
              'address': newAddress,
            },
          ),
        );
      },
    );
  }
}
