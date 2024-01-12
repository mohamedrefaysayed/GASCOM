part of 'sub_category_product_cubit.dart';

sealed class SubCategoryProductState {}

final class SubCategoryProductInitial extends SubCategoryProductState {}

final class SubCategoryProductLoading extends SubCategoryProductState {}

final class SubCategoryProductSuccess extends SubCategoryProductState {
  final SubCategoryProductsModel subCategoryProductsModel;
  SubCategoryProductSuccess({required this.subCategoryProductsModel});
}

final class SubCategoryProductFaliuer extends SubCategoryProductState {
  final String errMessage;
  SubCategoryProductFaliuer({required this.errMessage});
}
