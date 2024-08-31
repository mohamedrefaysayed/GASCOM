import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/helpers/dio_helper.dart';
import 'package:dinar_store/core/utils/constants.dart';
import 'package:dinar_store/core/utils/genrall.dart';
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
      Map<String, dynamic> data = await _dioHelper.postRequest(
        endPoint: isCustomer ? 'login_customer' : 'login_agent',
        queryParameters: {
          'mob_no': phoneNumber,
        },
        body: {},
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

      Map<String, dynamic> data = await _dioHelper.postRequest(
        endPoint: isCustomer ? 'otp_customer' : 'otp_agent',
        queryParameters: {
          'fcm': fcmToken,
          'mob_no': phoneNumber,
          'otp': otp,
        },
        body: {},
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
      Map<String, dynamic> data = await _dioHelper.postRequest(
        endPoint: 'signup_customer',
        queryParameters: {
          'mob_no': phoneNumber,
          'location': "${position.longitude},${position.latitude}",
          'name': name,
          'fcm': fcmToken,
        },
        body: {},
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
  Future<Either<ServerFailure, RegisterModel>> updateData({
    String? name,
    LatLng? position,
  }) async {
    try {
      Map<String, dynamic> data = await _dioHelper.postRequest(
        endPoint: 'signup_customer',
        queryParameters: {
          'mob_no': userPhone,
          if (position != null)
            'location': "${position.longitude},${position.latitude}",
          if (name != null) 'name': name,
        },
        body: {},
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
  Future<Either<ServerFailure, RegisterModel>> registerAgent({
    required String name,
    required String phoneNumber,
    required String agentNumber,
    required Position position,
    required File img,
    required String price,
  }) async {
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
      MultipartFile imgFile = await MultipartFile.fromFile(
        img.path,
        filename: img.path.split('/').last,
      );

      FormData formData = FormData.fromMap({
        'mob_no': phoneNumber,
        'agent_loc': "${position.longitude},${position.latitude}",
        'agent_name': name,
        'agent_no': agentNumber,
        'agent_price': price,
        'file': imgFile,
        'fcm': fcmToken,
      });
      Map<String, dynamic> data = await _dioHelper.postRequest(
        endPoint: 'signup_agent',
        body: formData,
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
  Future<Either<ServerFailure, RegisterModel>> updateDataAgent({
    String? name,
    LatLng? position,
    File? img,
  }) async {
    try {
      MultipartFile? imgFile;
      if (img != null) {
        imgFile = await MultipartFile.fromFile(
          img.path,
          filename: img.path.split('/').last,
        );
      }

      FormData formData = FormData.fromMap({
        'mob_no': userPhone!.trim().replaceAll('+', ""),
        if (position != null)
          'agent_loc': "${position.longitude},${position.latitude}",
        if (name != null) 'agent_name': name,
        if (img != null) 'file': imgFile!,
      });
      Map<String, dynamic> data = await _dioHelper.postRequest(
        endPoint: 'signup_agent',
        body: formData,
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
      await _dioHelper.getRequest(
        endPoint: isCustomer ? 'delete_customerr' : 'delete_agentt',
        token: AppCubit.token,
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
  Future<Either<String, String>> checkToken() async {
    try {
      Map<String, dynamic> data = await _dioHelper.getRequest(
        endPoint: 'check_token',
        token: AppCubit.token,
      );
      return right(data['token']);
    } on DioException catch (error) {
      return left(error.response!.data['token']);
    } catch (error) {
      return left(
        error.toString(),
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
