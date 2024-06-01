part of 'resetpin_cubit.dart';

class ResetpinState {}

class ResetpinInitial extends ResetpinState {}

class EmailFillState extends ResetpinState {}

class EmailEmptyState extends ResetpinState {
  String errorMessage;

  EmailEmptyState({required this.errorMessage});
}
