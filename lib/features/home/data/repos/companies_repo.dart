import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/companies_model.dart';

abstract class CompaniesRepo {
  Future<Either<ServerFailure, CompaniesModel>> getAllCompanies({
    required String token,
  });
}
