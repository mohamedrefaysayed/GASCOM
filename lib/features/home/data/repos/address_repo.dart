import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';

abstract class AddressRepo {
  Future<Either<ServerFailure, OrdersModel>> getAllOrders({
    required String token,
  });

  Future<Either<ServerFailure, void>> storeOrder({
    required String token,
    required int status,
    required double discount,
    required double tax,
    required int addressId,
    required List<OrderDetails> orderDetails,
  });

  Future<Either<ServerFailure, void>> deleteOrder({
    required String token,
    required int itemId,
  });
}
