// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/categories_model.dart';
import 'package:dinar_store/features/home/data/services/sub_categories_services.dart';
import 'package:flutter/material.dart';

part 'sub_categories_state.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  SubCategoriesCubit({required SubCategoriesServices subCategoriesServices})
      : super(SubCategoriesInitial()) {
    _subCategoriesServices = subCategoriesServices;
  }

  late SubCategoriesServices _subCategoriesServices;

  static List<SubCategories> subCategories = [];
  static List<SubCategories> subCategoriesSearch = [];
  static TextEditingController subCategoriesController =
      TextEditingController();

  getAllSubSubCategories({required int catId}) async {
    emit(SubCategoriesLoading());
    Either<ServerFailure, List<SubCategories>> result =
        await _subCategoriesServices.getAllSubCategories(
            token: AppCubit.token!, catId: catId);

    result.fold(
      //error
      (serverFailure) {
        emit(
          SubCategoriesFaliuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (categories) async {
        subCategories = categories;
        emit(SubCategoriesSuccess(categories: categories));
      },
    );
  }

  searchInSubCategory() {
    subCategoriesSearch = [];
    for (var element in subCategories) {
      if (element.categoryName!
          .toLowerCase()
          .contains(subCategoriesController.text.toLowerCase())) {
        subCategoriesSearch.add(element);
      }
      emit(SubCategoriesSuccess(categories: subCategories));
    }
  }
}
