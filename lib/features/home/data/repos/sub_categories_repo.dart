import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/categories_model.dart';

abstract class SubCategoriesRepo {
  Future<Either<ServerFailure, List<SubCategories>>> getAllSubCategories({
    required String token,
    required int catId,
  });
}
