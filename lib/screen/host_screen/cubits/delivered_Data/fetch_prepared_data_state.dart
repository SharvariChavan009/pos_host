part of 'fetch_prepared_data_cubit.dart';

@immutable
sealed class FetchPreparedDataState {}

final class FetchPreparedDataInitial extends FetchPreparedDataState {}

class GetAllDataErrorState1 extends FetchPreparedDataState {}

class GetPreparedDataLoadedState extends FetchPreparedDataState {
  final List<OrderModel> deliveredList;
  GetPreparedDataLoadedState({required this.deliveredList});
}
