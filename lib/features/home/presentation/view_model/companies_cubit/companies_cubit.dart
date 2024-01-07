// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/companies_model.dart';
import 'package:dinar_store/features/home/data/services/companies_services.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit({required CompaniesServices companiesServices})
      : super(CompaniesInitial()) {
    _companiesServices = companiesServices;
  }

  late CompaniesServices _companiesServices;

  getAllCompanies() async {
    emit(CompaniesLoading());
    Either<ServerFailure, CompaniesModel> result =
        await _companiesServices.getAllCompanies(token: AppCubit.token!);

    result.fold(
      //error
      (serverFailure) {
        emit(
          CompaniesFaliuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (companiesModel) async {
        emit(CompaniesSuccess(companiesModel: companiesModel));
      },
    );
  }
}
