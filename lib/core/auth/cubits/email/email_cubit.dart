import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';


part 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  EmailCubit() : super(EmailInitial()) {}

  void Loginvalidation1(String email, String pass) async {
    // if 1
    if (email.isEmpty && EmailValidator.validate(email) == false) {
      print("In - Email");
      emit(EmailValidatorState(errorMessage2: "Please enter valid email"));

      await Future.delayed(const Duration(seconds: 3), () {
        emit(EmailInitial()); // Prints after 1 second.
      });
    }
  }
}
