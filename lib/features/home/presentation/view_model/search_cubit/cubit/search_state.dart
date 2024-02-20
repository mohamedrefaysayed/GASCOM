part of 'search_cubit.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final SearchModel searchModel;
  SearchSuccess({required this.searchModel});
}

final class SearchFailuer extends SearchState {
  final String errMessage;
  SearchFailuer({required this.errMessage});
}
