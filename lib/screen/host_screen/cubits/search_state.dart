part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchSuccessState extends SearchState {
  List<OrderModel> searchList = [];

  SearchSuccessState({required this.searchList});
}

final class SearchFailuareState extends SearchState {}
