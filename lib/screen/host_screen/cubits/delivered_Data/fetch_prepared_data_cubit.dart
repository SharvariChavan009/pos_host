import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:host_task/core/common/api_constants.dart';
import 'package:host_task/screen/common/common_list.dart';
import 'package:host_task/screen/model/order_model.dart';

import 'package:meta/meta.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'fetch_prepared_data_state.dart';

class FetchPreparedDataCubit extends Cubit<FetchPreparedDataState> {
  FetchPreparedDataCubit() : super(FetchPreparedDataInitial()) {
    fetchPreparedlData();
  }

  Dio dio = Dio();
  void fetchPreparedlData() async {
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
        print(responseData[1]["order_id"]);

        

        // allOrderData.clear();
        // print("original order list${allOrderData.length}");

        // responseData.forEach((i) => allOrderData.add(OrderModel.fromJson(i)));
        // print("prder data lebgth${responseData.length}");

        // deliveredOrderData =
        //     allOrderData.where((order) => order.status == "Delivered").toList();
        // print("Delivered order count = ${deliveredOrderData.length}");

        // emit(GetPreparedDataLoadedState(deliveredList: deliveredOrderData));
        // print("<< User Token: $authVar >>");
      }
    } catch (e) {
      emit(GetAllDataErrorState1());
    }
  }
}
