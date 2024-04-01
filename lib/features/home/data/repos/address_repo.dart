import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationRepo {

  Future<Either<ServerFailure, void>> updateLocation({
    required String token,
    required Position location,
  });
}
