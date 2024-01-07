// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/categories_model.dart';
import 'package:dinar_store/features/home/data/services/categories_services.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required CategoriesServices categoriesServices})
      : super(CategoriesInitial()) {
    _categoriesServices = categoriesServices;
  }

  late CategoriesServices _categoriesServices;

  getAllCategories() async {
    emit(CategoriesLoading());
    Either<ServerFailure, CategoriesModel> result =
        await _categoriesServices.getAllCategories(token: AppCubit.token!);

    result.fold(
      //error
      (serverFailure) {
        emit(
          CategoriesFaliuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (categoriesModel) async {
        emit(CategoriesSuccess(categoriesModel: categoriesModel));
      },
    );
  }
}
