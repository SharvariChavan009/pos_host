import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  Dio dio = Dio();

  LoginCubit() : super(LoginInitial()) {}

//------------ Functions -----------------

  void Loginvalidation(String email, String pass) async {
    // if 2
    if (pass.length <= 7) {
      print("In - PIN");
      emit(ErrorState1(errorMessage2: "Please enter valid password"));

      await Future.delayed(const Duration(seconds: 3), () {
        emit(LoginInitial()); // Prints after 1 second.
      });
    }
  }
}
