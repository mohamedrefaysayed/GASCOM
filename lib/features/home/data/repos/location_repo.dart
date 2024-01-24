import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:geocoding/geocoding.dart';

abstract class LocationRepo {
  Future<Either<ServerFailure, Placemark>> convertPositionToAddress({
    required double lat,
    required double lng,
  });
}
