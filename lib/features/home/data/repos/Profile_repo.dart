// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/profile_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class ProfileRepo {
  Future<Either<ServerFailure, ProfileModel>> getProfile({
    required String token,
  });

  Future<Either<ServerFailure, ProfileModel>> updateProfile({
    required String token,
    String? name,
    LatLng? location,
  });
}
