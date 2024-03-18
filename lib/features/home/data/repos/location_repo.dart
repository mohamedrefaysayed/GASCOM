import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationRepo {
  Future<Either<ServerFailure, Position>> getLocation();

  Stream<Future<Either<ServerFailure, Position>>> getLocationPeriodically();

  Future<Either<ServerFailure, void>> updateUserLocation({
    required String token,
    required Position position,
  });

  Future<Either<ServerFailure, Placemark>> convertPositionToAddress({
    required double lat,
    required double lng,
  });
}
