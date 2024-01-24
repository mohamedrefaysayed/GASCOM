// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/profile_model.dart';
import 'package:dinar_store/features/home/data/services/profile_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required ProfileServices profileServices,
  }) : super(ProfileInitial()) {
    _profileServices = profileServices;
  }

  late ProfileServices _profileServices;

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
      (profileModel) async {
        emit(ProfileSuccess(profileModel: profileModel));
      },
    );
  }
}
