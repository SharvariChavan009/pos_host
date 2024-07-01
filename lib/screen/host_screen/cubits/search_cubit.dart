import 'package:bloc/bloc.dart';
import 'package:host_task/screen/model/order_model.dart';
import 'package:meta/meta.dart';

import '../../common/common_list.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial()) {}

  // Search Function

  void searchFunctio(String value) async {
    List<OrderModel> filteredData;
    List<OrderModel> users = readyOrderData;
    //
    filteredData = users
        .where((userItem) =>
        userItem.tableNo!.toString().contains(value))
        .toList();

    print("searchlist=${filteredData.length}");

    // print('Filtered Data Length: ${filteredData.length}');
    emit(SearchSuccessState(searchList: filteredData));
  }
}
