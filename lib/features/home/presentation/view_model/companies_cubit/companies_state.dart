part of 'companies_cubit.dart';

sealed class CompaniesState {}

final class CompaniesInitial extends CompaniesState {}

final class CompaniesLoading extends CompaniesState {}

final class CompaniesSuccess extends CompaniesState {
  final CompaniesModel companiesModel;
  CompaniesSuccess({required this.companiesModel});
}

final class CompaniesFaliuer extends CompaniesState {
  final String errMessage;
  CompaniesFaliuer({required this.errMessage});
}
