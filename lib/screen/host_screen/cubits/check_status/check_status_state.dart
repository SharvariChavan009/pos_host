part of 'check_status_cubit.dart';

@immutable
sealed class CheckStatusState {}

final class CheckStatusInitial extends CheckStatusState {}
final class CheckStatusPlacedState extends CheckStatusState {
  List<OrderModel> placedData;

  CheckStatusPlacedState({required this.placedData});
}

final class CheckStatusPreparedState extends CheckStatusState {
  List<OrderModel> preparedData;

  CheckStatusPreparedState({required this.preparedData});
}
final class CheckStatusErrordState extends CheckStatusState {
  
}
