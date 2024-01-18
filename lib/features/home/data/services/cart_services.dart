import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/helpers/dio_helper.dart';
import 'package:dinar_store/features/home/data/models/categories_model.dart';
import 'package:dinar_store/features/home/data/repos/cart_repo.dart';
import 'package:dio/dio.dart';

class CartServices implements CartRepo {
  CartServices({
    required DioHelper dioHelper,
  }) {
    _dioHelper = dioHelper;
  }

  late DioHelper _dioHelper;

  String? fcmToken;

  @override
  Future<Either<ServerFailure, CategoriesModel>> getAllItems(
      {required String token}) async {
    CategoriesModel categoriesModel;
    try {
      Map<String, dynamic> data = await _dioHelper.getRequest(
        token: token,
        endPoint: 'categories',
      );
      categoriesModel = CategoriesModel.fromJson(data);
      return right(categoriesModel);
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
  Future<Either<ServerFailure, void>> storeItem({
    required String token,
    required int productId,
    required int quantity,
    required int unitId,
    required double price,
  }) async {
    try {
      await _dioHelper.postRequest(token: token, endPoint: 'cart', body: {
        'product_id': productId,
        'quantity': quantity,
        'unit_id': unitId,
        'price': price,
      });
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
}
