import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:host_task/core/common/api_constants.dart';
import 'package:meta/meta.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial()) {}

  // Functions
  void logout() async {
    var userTokenBox = await Hive.openBox("authBox");
    var token = await userTokenBox.get("authToken");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var dio = Dio();
    var response = await dio.request(
      ApiConstants.apiLogoutUrl,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));

      final success = response.data['data'] != null;
      if (success) {
        userTokenBox.delete('authToken');
        Hive.close();
        emit(LogoutSuccessState());
        await Future.delayed(const Duration(seconds: 2), () {
          emit(LogoutInitial());
        });
        print("Logout Successfull");
      } else {
        emit(LogoutErrorState());
      }
    } else {
      print(response.statusMessage);
      print("Logout Failed");
    }
  }
}
