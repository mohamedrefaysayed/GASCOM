import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/helpers/dio_helper.dart';
import 'package:dinar_store/core/utils/constants.dart';
import 'package:dinar_store/features/auth/data/models/model/login_model.dart';
import 'package:dinar_store/features/auth/data/models/model/register_model.dart';
import 'package:dinar_store/features/auth/data/models/model/verfiy_model.dart';
import 'package:dinar_store/features/auth/data/repos/log_in_repo.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:map_location_picker/map_location_picker.dart';

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
  Future<Either<ServerFailure, LoginModel>> logIn({
    required String phoneNumber,
  }) async {
    try {
      Map<String, dynamic> data = await _dioHelper.getRequest(
        endPoint: 'login_customer',
        queryParameters: {
          'mob_no': phoneNumber,
        },
      );
      return right(
        LoginModel.fromJson(data),
      );
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
  Future<Either<ServerFailure, VerfiyModel>> verify({
    required String otp,
    required String phoneNumber,
  }) async {
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
      Map<String, dynamic> data = await _dioHelper.getRequest(
        endPoint: 'otp_customer',
        queryParameters: {
          'fcm': fcmToken,
          'mob_no': phoneNumber,
          'otp': otp,
        },
      );
      return right(
        VerfiyModel.fromJson(data),
      );
    } on DioException catch (_) {
      return left(
        ServerFailure(errMessage: "الرقم خطأ"),
      );
    } catch (error) {
      return left(
        ServerFailure(errMessage: error.toString()),
      );
    }
  }

  @override
  Future<Either<ServerFailure, RegisterModel>> register({
    required String name,
    required String phoneNumber,
    required Position position,
  }) async {
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
      Map<String, dynamic> data = await _dioHelper.getRequest(
        endPoint: 'signup_customer',
        queryParameters: {
          'mob_no': phoneNumber,
          'location': "${position.longitude},${position.latitude}",
          'name': name,
          'fcm': fcmToken,
        },
      );
      return right(
        RegisterModel.fromJson(data),
      );
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
  Future<Either<ServerFailure, void>> deleteAccount() async {
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
      await _dioHelper.getRequest(
        endPoint: 'delete_customerr',
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

  @override
  Future<void> storeTokenInSecureStorage({required String token}) async {
    AppCubit.token = token;

    await _secureStorage.write(key: kSecureStorageKey, value: token);
  }

  @override
  Future<String?> getTokenFromSecureStorage() async {
    String? token = await _secureStorage.read(key: kSecureStorageKey);
    AppCubit.token = token;

    return token;
  }
}
