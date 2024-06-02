import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:host_task/core/common/api_constants.dart';
import 'package:meta/meta.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'get_user_details_state.dart';

class GetUserDetailsCubit extends Cubit<GetUserDetailsState> {
  GetUserDetailsCubit() : super(GetUserDetailsInitial()) {
    getUserDetails();
  }

  // Functions

  void getUserDetails() async {
    var userTokenBox = await Hive.openBox("authBox");
    var token = await userTokenBox.get("authToken");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var dio = Dio();

    dio.interceptors.add(PrettyDioLogger());

    var response = await dio.request(
      ApiConstants.apiProfileUrl,
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));

      String profileName = response.data["data"]["user"]["name"];

      var usernameBox = await Hive.openBox("usernameBox");
      usernameBox.put("profileName", profileName);

      print("Successfull fetch profile Name: $profileName");

      emit(GetUserDetailsSuccessState(userName: profileName));
    } else {
      print(response.statusMessage);
      print("Failed fetch profile Details");
      emit(GetUserDetailsErrorState(errorName: "Username Not found"));
    }
  }
}
