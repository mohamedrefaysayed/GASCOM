import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/ads_model.dart';

abstract class AdsRepo {
  Future<Either<ServerFailure, AdsModel>> getAllAds({
    required String token,
  });
}
