part of 'check_email_pass_cubit.dart';

sealed class CheckEmailPassState  {

}

final class CheckEmailPassInitial extends CheckEmailPassState {}

class LoginSuccessfulState extends CheckEmailPassState {}

class LoginFailedfulState extends CheckEmailPassState {}
class LoadingState extends CheckEmailPassState {}