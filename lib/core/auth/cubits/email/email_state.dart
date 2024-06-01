part of 'email_cubit.dart';

sealed class EmailState   {

}

final class EmailInitial extends EmailState {}

class EmailValidatorState extends EmailState {
  String errorMessage2;

  EmailValidatorState({required this.errorMessage2});
}
