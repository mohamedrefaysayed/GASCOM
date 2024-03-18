import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/helpers/dio_helper.dart';
import 'package:dinar_store/features/home/data/models/cart_items_model.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:dinar_store/features/home/data/models/suppliers_model.dart';
import 'package:dinar_store/features/home/data/repos/orders_repo.dart';
import 'package:dio/dio.dart';

class OrdersServices implements OrdersRepo {
  OrdersServices({
    required DioHelper dioHelper,
  }) {
    _dioHelper = dioHelper;
  }

  late DioHelper _dioHelper;

  String? fcmToken;

  @override
  Future<Either<ServerFailure, OrdersModel>> getAllOrders(
      {required String token}) async {
    OrdersModel ordersModel = OrdersModel();
    try {
      Map<String, dynamic> data = await _dioHelper.getRequest(
        token: token,
        endPoint: 'orders',
      );
      ordersModel = OrdersModel.fromJson(data);
      return right(ordersModel);
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
  Future<Either<ServerFailure, void>> storeOrder({
    required String userPhone,
    required String supplierPhone,
    required int tubsNumber,
    required int totalPrice,
    required String token,
  }) async {
    try {
      await _dioHelper.getRequest(
        token: token,
        endPoint: 'place_order',
        queryParameters: {
          'customer_mob_no': userPhone,
          'agent_mob_no': supplierPhone,
          'no_disks': tubsNumber,
          'total_price': totalPrice,
        },
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
  Future<Either<ServerFailure, CartItemsModel>> deleteOrder({
    required String token,
    required int itemId,
  }) async {
    CartItemsModel cartItemsModel;
    try {
      Map<String, dynamic> data = await _dioHelper.postRequest(
        token: token,
        endPoint: 'orders/$itemId',
        body: {
          '_method': "delete",
          'id': itemId,
        },
      );
      cartItemsModel = CartItemsModel.fromJson(data);
      return right(cartItemsModel);
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
  Future<Either<ServerFailure, SuppliersModel>> getSuppliers({
    required String phone,
    required String token,
  }) async {
    SuppliersModel suppliersModel;
    try {
      Map<String, dynamic> data = await _dioHelper.getRequest(
        token: token,
        endPoint: 'view_agents',
        queryParameters: {
          'customer_mob_no': phone,
        },
      );
      suppliersModel = SuppliersModel.fromJson(data);
      return right(suppliersModel);
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
