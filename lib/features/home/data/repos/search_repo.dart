import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';

abstract class SearchRepo {
  Future<Either<ServerFailure, void>> search({
    required String token,
    required String keyWord,
  });
}
