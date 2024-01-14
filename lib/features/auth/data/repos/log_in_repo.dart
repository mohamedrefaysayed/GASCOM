import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';

abstract class LogInRepo {
  Future<Either<ServerFailure, dynamic>> register({
    required String countryCode,
    required String phoneNumber,
  });

  Future<Either<ServerFailure, dynamic>> sendVCode({
    required String code,
  });

  ///use flutter secure storage to store the token
  Future<void> storeTokenInSecureStorage({
    required String token,
  });
}
