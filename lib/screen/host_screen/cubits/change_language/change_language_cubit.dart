import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit() : super(ChangeLanguageInitial()) {}

  void ChangelanguageFunction(Locale type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (type == Locale('en')) {
      await sp.setString("language", 'en');
      emit(ChangeLanguageSuccess(Locale('en')));
    } else {
      await sp.setString("language", 'ar');
      emit(ChangeLanguageSuccess(Locale('ar')));
    }
  }
}
