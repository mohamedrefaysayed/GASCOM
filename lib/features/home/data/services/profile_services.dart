import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/helpers/dio_helper.dart';
import 'package:dinar_store/core/utils/genrall.dart';
import 'package:dinar_store/features/home/data/models/profile_model.dart';
import 'package:dinar_store/features/home/data/repos/Profile_repo.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileServices implements ProfileRepo {
  ProfileServices({
    required DioHelper dioHelper,
  }) {
    _dioHelper = dioHelper;
  }

  late DioHelper _dioHelper;

  @override
  Future<Either<ServerFailure, ProfileModel>> getProfile({
    required String token,
  }) async {
    ProfileModel profileModel;
    try {
      Map<String, dynamic> data = await _dioHelper.getRequest(
        token: token,
        endPoint: isCustomer ? 'customer_data' : 'agent_data',
      );
      profileModel = ProfileModel.fromJson(data);
      return right(profileModel);
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
  Future<Either<ServerFailure, ProfileModel>> updateProfile({
    required String token,
    String? name,
    LatLng? location,
  }) async {
    ProfileModel profileModel;
    try {
      Map<String, dynamic> data = await _dioHelper.getRequest(
        token: token,
        endPoint: isCustomer ? 'signup_customer' : 'api/signup_agent',
      );
      profileModel = ProfileModel.fromJson(data);
      return right(profileModel);
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
}
