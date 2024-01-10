import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/helpers/dio_helper.dart';
import 'package:dinar_store/features/home/data/models/categories_model.dart';
import 'package:dinar_store/features/home/data/repos/sub_categories_repo.dart';
import 'package:dio/dio.dart';

class SubCategoriesServices implements SubCategoriesRepo {
  SubCategoriesServices({
    required DioHelper dioHelper,
  }) {
    _dioHelper = dioHelper;
  }

  late DioHelper _dioHelper;

  String? fcmToken;

  @override
  Future<Either<ServerFailure, List<SubCategories>>> getAllSubCategories({
    required String token,
    required int catId,
  }) async {
    List<SubCategories> subCategories = [];
    try {
      Map<String, dynamic> data = await _dioHelper.getRequest(
        token: token,
        endPoint: 'categories/show_by_parent/$catId',
      );
      await data['categories'].forEach((v) {
        subCategories.add(SubCategories.fromJson(v));
      });
      return right(subCategories);
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
