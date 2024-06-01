part of 'login_cubit.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class ErrorState1 extends LoginState {
  String errorMessage2;

  ErrorState1({required this.errorMessage2});
}



