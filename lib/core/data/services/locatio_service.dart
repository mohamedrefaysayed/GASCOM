import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/repos/location_repo.dart';
import 'package:geocoding/geocoding.dart';

class LocationServices implements LocationRepo {
  @override
  Future<Either<ServerFailure, Placemark>> convertPositionToAddress({
    required double lat,
    required double lng,
  }) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        lng,
      );

      if (placemarks.isNotEmpty) {
        return right(placemarks.first);
      } else {
        return left(
          ServerFailure(errMessage: 'Address not found'),
        );
      }
    } catch (e) {
      return left(
        ServerFailure(errMessage: e.toString()),
      );
    }
  }
}
