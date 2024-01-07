part of 'categories_cubit.dart';

sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final CategoriesModel categoriesModel;
  CategoriesSuccess({required this.categoriesModel});
}

final class CategoriesFaliuer extends CategoriesState {
  final String errMessage;
  CategoriesFaliuer({required this.errMessage});
}
