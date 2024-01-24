// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<ServerFailure, ProfileModel>> getProfile({
    required String token,
  });
}
