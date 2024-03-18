import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/helpers/dio_helper.dart';
import 'package:dinar_store/features/home/data/repos/location_repo.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices implements LocationRepo {
  LocationServices({required DioHelper dioHelper}) {
    _dioHelper = dioHelper;
  }

  late DioHelper _dioHelper;

  @override
  Future<Either<ServerFailure, Position>> getLocation() async {
    bool isPermissionAccepted = await _getPermission();

    if (isPermissionAccepted) {
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        Position currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );

        return right(currentLocation);
      } else {
        return left(
          ServerFailure(errMessage: 'Turn On GPS First'),
        );
      }
    } else {
      return left(
        ServerFailure(errMessage: 'Accept Location Permission To Continue'),
      );
    }
  }

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

  @override
  Stream<Future<Either<ServerFailure, Position>>>
      getLocationPeriodically() async* {
    yield* Stream.periodic(
      const Duration(seconds: 15),
      (computationCount) async {
        if (await _getPermission()) {
          try {
            Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.bestForNavigation,
            );
            return right(position);
          } catch (error) {
            return left(
              ServerFailure(errMessage: error.toString()),
            );
          }
        } else {
          return left(
            ServerFailure(errMessage: 'Location Permission Is Denied'),
          );
        }
      },
    );
  }

  @override
  Future<Either<ServerFailure, void>> updateUserLocation(
      {required String token, required Position position}) async {
    try {
      await _dioHelper.postRequest(
        token: token,
        endPoint: 'asdc-client-user/send-client-user-location',
        body: {
          'asdc_client_gps_location':
              'https://www.google.com/maps?q=${position.latitude},${position.longitude}',
        },
      );
      return right(null);
    } on DioException catch (error) {
      return left(
        ServerFailure.fromDioException(dioException: error),
      );
    } catch (error) {
      return left(
        ServerFailure(errMessage: error.toString()),
      );
    }
  }

  Future<bool> _getPermission() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.whileInUse ||
        locationPermission == LocationPermission.always) {
      return true;
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.whileInUse ||
          locationPermission == LocationPermission.always) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
