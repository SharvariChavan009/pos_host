part of 'change_language_cubit.dart';

@immutable
sealed class ChangeLanguageState {}

final class ChangeLanguageInitial extends ChangeLanguageState {}

final class ChangeLanguageLoading extends ChangeLanguageState {}

final class ChangeLanguageSuccess extends ChangeLanguageState {
  Locale? name;
  ChangeLanguageSuccess(this.name);
}

final class ChangeLanguageFailure extends ChangeLanguageState {}
