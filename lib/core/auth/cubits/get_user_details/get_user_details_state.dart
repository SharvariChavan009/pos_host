part of 'get_user_details_cubit.dart';

@immutable
sealed class GetUserDetailsState {}

final class GetUserDetailsInitial extends GetUserDetailsState {}

final class GetUserDetailsSuccessState extends GetUserDetailsState {
  String userName;

  GetUserDetailsSuccessState({required this.userName});
}
final class GetUserDetailsErrorState extends GetUserDetailsState {
  String errorName;

  GetUserDetailsErrorState({required this.errorName});

}