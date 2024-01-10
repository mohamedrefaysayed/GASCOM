part of 'sub_categories_cubit.dart';

sealed class SubCategoriesState {}

final class SubCategoriesInitial extends SubCategoriesState {}

final class SubCategoriesLoading extends SubCategoriesState {}

final class SubCategoriesSuccess extends SubCategoriesState {
  final List<SubCategories> categories;
  SubCategoriesSuccess({required this.categories});
}

final class SubCategoriesFaliuer extends SubCategoriesState {
  final String errMessage;
  SubCategoriesFaliuer({required this.errMessage});
}
