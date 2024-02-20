import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/core/helpers/dio_helper.dart';
import 'package:dinar_store/features/home/data/models/cart_items_model.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:dinar_store/features/home/data/repos/address_repo.dart';
import 'package:dio/dio.dart';

class AddressServices implements AddressRepo {
  AddressServices({
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
  Future<Either<ServerFailure, OrdersModel>> storeOrder({
    required String token,
    required int status,
    required double discount,
    required double tax,
    required int addressId,
    required List<OrderDetails> orderDetails,
  }) async {
    try {
      List<String> orderDetailsJson = [];
      for (OrderDetails element in orderDetails) {
        orderDetailsJson.add(element.toString());
      }

      OrdersModel ordersModel;
      Map<String, dynamic> data = await _dioHelper.postRequest(
        token: token,
        endPoint: 'orders',
        body: {
          'status': status,
          'discount': discount,
          'tax': tax,
          'address_id': addressId,
          'order_details': orderDetailsJson,
        },
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
}
