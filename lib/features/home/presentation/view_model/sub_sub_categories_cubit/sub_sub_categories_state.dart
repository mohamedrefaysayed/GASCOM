part of 'sub_sub_categories_cubit.dart';

sealed class SubSubCategoriesState {}

final class SubSubCategoriesInitial extends SubSubCategoriesState {}

final class SubSubCategoriesLoading extends SubSubCategoriesState {}

final class SubSubCategoriesSuccess extends SubSubCategoriesState {
  final List<SubCategories> categories;
  SubSubCategoriesSuccess({required this.categories});
}

final class SubSubCategoriesFaliuer extends SubSubCategoriesState {
  final String errMessage;
  SubSubCategoriesFaliuer({required this.errMessage});
}
