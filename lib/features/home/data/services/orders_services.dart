import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/helpers/dio_helper.dart';
import 'package:dinar_store/core/utils/genrall.dart';
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
        endPoint: isCustomer ? 'view_customer_orders' : 'view_orders',
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
  Future<Either<ServerFailure, SuppliersModel>> getSuppliers({
    required String token,
  }) async {
    SuppliersModel suppliersModel;
    try {
      Map<String, dynamic> data = await _dioHelper.getRequest(
        token: token,
        endPoint: 'view_agents',
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

  @override
  Future<Either<ServerFailure, OrdersModel>> getAllAgentOrders({
    required String token,
  }) async {
    OrdersModel ordersModel;
    try {
      Map<String, dynamic> data = await _dioHelper.getRequest(
        token: token,
        endPoint: 'review_orders',
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
  Future<Either<ServerFailure, void>> approveOrder({
    required String token,
    required String orderId,
  }) async {
    try {
      await _dioHelper.getRequest(
        token: token,
        endPoint: 'approve',
        queryParameters: {
          'order_id': orderId,
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
  Future<Either<ServerFailure, void>> rejectOrder({
    required String token,
    required String orderId,
  }) async {
    try {
      await _dioHelper.getRequest(
        token: token,
        endPoint: 'reject',
        queryParameters: {
          'order_id': orderId,
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
  Future<Either<ServerFailure, void>> deleverOrder({
    required String token,
    required String orderId,
  }) async {
    try {
      await _dioHelper.getRequest(
        token: token,
        endPoint: 'delivered',
        queryParameters: {
          'order_id': orderId,
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
  Future<Either<ServerFailure, void>> changePrice({
    required String token,
    required String newPrice,
  }) async {
    try {
      await _dioHelper.getRequest(
        token: token,
        endPoint: 'change_price',
        queryParameters: {
          'price': newPrice,
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
}
