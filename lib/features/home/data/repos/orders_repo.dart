import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:dinar_store/features/home/data/models/suppliers_model.dart';

abstract class OrdersRepo {
  Future<Either<ServerFailure, OrdersModel>> getAllOrders({
    required String token,
  });

  Future<Either<ServerFailure, void>> storeOrder({
    required String userPhone,
    required String supplierPhone,
    required int tubsNumber,
    required int totalPrice,
    required String token,
  });

  Future<Either<ServerFailure, SuppliersModel>> getSuppliers({
    required String token,
  });

  Future<Either<ServerFailure, OrdersModel>> getAllAgentOrders({
    required String token,
  });

  Future<Either<ServerFailure, void>> approveOrder({
    required String token,
    required String orderId,
  });
  Future<Either<ServerFailure, void>> rejectOrder({
    required String token,
    required String orderId,
  });

  Future<Either<ServerFailure, void>> deleverOrder({
    required String token,
    required String orderId,
  });

  Future<Either<ServerFailure, void>> changePrice({
    required String token,
    required String newPrice,
  });
}
