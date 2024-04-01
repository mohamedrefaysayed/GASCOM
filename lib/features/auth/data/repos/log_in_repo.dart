import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/auth/data/models/model/login_model.dart';
import 'package:dinar_store/features/auth/data/models/model/register_model.dart';
import 'package:dinar_store/features/auth/data/models/model/verfiy_model.dart';

import 'package:map_location_picker/map_location_picker.dart';

abstract class LogInRepo {
  Future<Either<ServerFailure, LoginModel>> logIn({
    required String phoneNumber,
  });

  Future<Either<ServerFailure, VerfiyModel>> verify({
    required String otp,
    required String phoneNumber,
  });

  Future<Either<ServerFailure, RegisterModel>> register({
    required String name,
    required String phoneNumber,
    required Position position,
  });

  Future<Either<ServerFailure, void>> deleteAccount();

  ///use flutter secure storage to store the token
  Future<void> storeTokenInSecureStorage({
    required String token,
  });

  ///use flutter secure storage to get the token
  Future<void> getTokenFromSecureStorage();
}
