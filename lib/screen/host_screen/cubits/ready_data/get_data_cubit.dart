import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:host_task/core/common/api_constants.dart';
import 'package:host_task/screen/common/common_list.dart';
import 'package:host_task/screen/model/order_model.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  GetDataCubit() : super(GetDataInitial()) {
    fetchReadyData();
  }

  // Functions
  Dio dio = Dio();

  // Fetch All Data
  void fetchReadyData() async {
    var box = await Hive.openBox("authBox");
    String authVar = box.get("authToken");

    try {
      dio.interceptors.add(PrettyDioLogger());

      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authVar'
      };

      Response response = await dio.get(
        ApiConstants.apiHostReadyUrl,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        final responseData = response.data['data'] as List;
        allOrderData.clear();
        responseData.forEach((i) => allOrderData.add(OrderModel.fromJson(i)));
        readyOrderData =
            allOrderData.where((order) => order.status == "Ready").toList();
        print("Ready order count = ${readyOrderData.length}");

        emit(GetPlacedDataLoadedState(readyList: readyOrderData));
        print("<< User Token: $authVar >>");
      }
    } catch (e) {
      emit(GetAllDataErrorState());
    }
  }
}
