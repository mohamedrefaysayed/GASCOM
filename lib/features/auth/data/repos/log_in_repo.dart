import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';

abstract class LogInRepo {
  Future<Either<ServerFailure, String>> logIn({
    required String email,
    required String password,
  });

  ///use flutter secure storage to store the token
  Future<void> storeTokenInSecureStorage({
    required String token,
  });
}
