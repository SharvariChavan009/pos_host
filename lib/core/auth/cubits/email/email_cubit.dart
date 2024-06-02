import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';

part 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  EmailCubit() : super(EmailInitial()) {}

  void Loginvalidation1(String email, String pass) async {
    String patttern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(patttern);
    if (email.isEmpty) {
      emit(EmailValidatorState(errorMessage2: "Please enter email address"));
    } else if (!regExp.hasMatch(email)) {
      emit(EmailValidatorState(
          errorMessage2: "Please enter valid email address"));
    }
    return await Future.delayed(const Duration(seconds: 3), () {
      emit(EmailInitial()); // Prints after 1 second.
    });
  }
}
