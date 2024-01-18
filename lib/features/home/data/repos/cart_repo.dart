import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/categories_model.dart';

abstract class CartRepo {
  Future<Either<ServerFailure, CategoriesModel>> getAllItems({
    required String token,
  });

  Future<Either<ServerFailure, void>> storeItem({
    required String token,
    required int productId,
    required int quantity,
    required int unitId,
    required double price,
  });
}
