// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/categories_model.dart';
import 'package:dinar_store/features/home/data/services/sub_categories_services.dart';
import 'package:flutter/material.dart';

part 'sub_sub_categories_state.dart';

class SubSubCategoriesCubit extends Cubit<SubSubCategoriesState> {
  SubSubCategoriesCubit({required SubCategoriesServices subCategoriesServices})
      : super(SubSubCategoriesInitial()) {
    _subCategoriesServices = subCategoriesServices;
  }

  late SubCategoriesServices _subCategoriesServices;

  static List<SubCategories> subCategories = [];
  static List<SubCategories> subCategoriesSearch = [];
  static TextEditingController subCategoriesController =
      TextEditingController();

  getAllSubCategories({required int catId}) async {
    emit(SubSubCategoriesLoading());
    Either<ServerFailure, List<SubCategories>> result =
        await _subCategoriesServices.getAllSubCategories(
            token: AppCubit.token!, catId: catId);

    result.fold(
      //error
      (serverFailure) {
        emit(SubSubCategoriesFaliuer(errMessage: serverFailure.errMessage));
      },
      //success
      (categories) async {
        emit(SubSubCategoriesSuccess(categories: categories));
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
      emit(SubSubCategoriesSuccess(categories: subCategories));
    }
  }
}
