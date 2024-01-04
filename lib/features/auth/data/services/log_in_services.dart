import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/helpers/dio_helper.dart';
import 'package:dinar_store/core/utils/constants.dart';
import 'package:dinar_store/features/auth/data/repos/log_in_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogInServices implements LogInRepo {
  LogInServices({
    required DioHelper dioHelper,
    required FlutterSecureStorage secureStorage,
  }) {
    _dioHelper = dioHelper;
    _secureStorage = secureStorage;
  }

  late DioHelper _dioHelper;
  late FlutterSecureStorage _secureStorage;
  String? fcmToken;

  @override
  Future<Either<ServerFailure, String>> logIn(
      {required String email, required String password}) async {
    try {
      Map<String, dynamic> data = await _dioHelper.postRequest(
        body: {
          'email': email,
          'password': password,
        },
        endPoint: 'auth/client-mobile/login',
        queryParameters: {'token': fcmToken},
      );
      return right(data.toString());
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

  @override
  Future<void> storeTokenInSecureStorage({required String token}) async {
    await _secureStorage.write(key: kSecureStorageKey, value: token);
  }
}
