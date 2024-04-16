// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/profile_model.dart';
import 'package:dinar_store/features/home/data/services/profile_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required ProfileServices profileServices,
  }) : super(ProfileInitial()) {
    _profileServices = profileServices;
  }

  late ProfileServices _profileServices;

  static TextEditingController priceController = TextEditingController();

  static TextEditingController nameController = TextEditingController();

  static LatLng? markerPosition;

  static Marker? marker;

  static String currentAddress = "أختر عنوان";

  static ProfileModel? profileModel;

  getProfile() async {
    emit(ProfileLoading());
    Either<ServerFailure, ProfileModel> result =
        await _profileServices.getProfile(
      token: AppCubit.token!,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          ProfileFaliuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (profilemodel) async {
        profileModel = profilemodel;
        emit(ProfileSuccess(profileModel: profilemodel));
      },
    );
  }

  updateProfile() async {
    emit(UpdateProfileLoading());
    Either<ServerFailure, void> result = await _profileServices.getProfile(
      token: AppCubit.token!,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          UpdateProfileFaliuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (_) async {
        emit(UpdateProfileSuccess());
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
    emit(ProfileUpdate());

    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress = '${place.street}';
      emit(ProfileUpdate());
    });
  }
}
