import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_task/screen/host_screen/cubits/ready_data/get_data_cubit.dart';

import '../../core/common/colors.dart';
import '../common/common_list.dart';
import '../model/order_model.dart';
import 'cubits/check_status/check_status_cubit.dart';
import 'cubits/delivered_Data/fetch_prepared_data_cubit.dart';

class OrderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order List'),
        ),
        body: SingleChildScrollView(child: Column(
          children: [
            Container(
              color: Colors.orange,
              width: double.infinity,
              child: Expanded(child: Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: BlocBuilder<GetDataCubit, GetDataState>(
                        builder: (context, state) {
                          List<OrderModel> orderList;
                          if(state is GetPlacedDataLoadedState){
                            print("ready order data count =${state.readyList.length}");
                            orderList = state.readyList;
                            orders1 = orderList;
                          }


                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            orders1.map((order) => OrderCard(order: order))
                                .toList(),
                          );
                        },
                      ))
              )),),
            // Container(
            //   width: double.infinity,
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: orders2.map((order) => OrderCard(order: order))
            //           .toList(),
            //     ),
            //   ),
            // ),
          ],
        ),
        ));
  }
}

List<DropdownMenuItem<String>> _dropDownItem() {
  List<String> itemValue = ["Ready", "Delivered"];

  return itemValue
      .map((value) =>
      DropdownMenuItem(
        value: value,
        child: Text(value),
      ))
      .toList();
}

List<String> selectedItemValue = []; // ready

class OrderCard extends StatelessWidget {
  final OrderModel order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(10.0),
      child: Container(
        width: 300, // Adjust the width as needed
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Text(
            //       "Order No: ${order.orderNo}",
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 18,
            //       ),
            //     ),
            //   ],
            // ),
             Row(
              children: [
                AutoSizeText(
                  "orderno: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  minFontSize: 14,
                  maxFontSize: 18,
                ),
                AutoSizeText(
                  order!.orderId.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  minFontSize: 14,
                  maxFontSize: 18,
                ),
              ],
            ),
            // Row(
            //   children: [
            //     Text(
            //       "Table No: ${order.tableNo}",
            //       style: TextStyle(
            //         fontSize: 18,
            //       ),
            //     ),
            //   ],
            // ),
             Row(
              children: [
                AutoSizeText(
                  "tableno: ",
                  style: TextStyle(
                    color: AppColors.newTextColor,
                    fontSize: 18,
                  ),
                  minFontSize: 14,
                  maxFontSize: 18,
                ),
                AutoSizeText(
                  order.tableNo.toString(),
                  style: TextStyle(
                    color: AppColors.newTextColor,
                    fontSize: 18,
                  ),
                  minFontSize: 14,
                  maxFontSize: 18,
                ),
              ],
            ),
            AutoSizeText(
              "Order Items: ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              minFontSize: 14,
              maxFontSize: 18,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: order.items!.length,
              itemBuilder: (BuildContext context, int index) {
                final item = order.items![index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item!.name!,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 7.0),
                      child: Text(
                        item!.quatity!.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              dropdownColor: Colors.white,
              value: "Ready",
              items: _dropDownItem(),
              onChanged: (value) {
                print(value);
                status = value;
                 id = order
                    .orderId
                    .toString();
                //
                BlocProvider.of<
                    CheckStatusCubit>(
                    context)
                    .CheckStatusData();

                BlocProvider.of<
                    GetDataCubit>(
                    context)
                    .fetchReadyData();

                BlocProvider.of<
                    FetchPreparedDataCubit>(
                    context)
                    .fetchPreparedlData();
              },
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}


class Order {
  final int orderNo;
  final int tableNo;
  final List<Item> items;

  Order({required this.orderNo, required this.tableNo, required this.items});
}

class Item {
  final String name;
  final int quantity;

  Item({required this.name, required this.quantity});
}

// Sample data
List<OrderModel> orders1 = [
];

List<Order> orders2 = [
  Order(orderNo: 3, tableNo: 103, items: [
    Item(name: 'Pasta', quantity: 1),
    Item(name: 'Salad', quantity: 1),
    Item(name: 'Soup', quantity: 1),
  ]),
  Order(orderNo: 4, tableNo: 104, items: [
    Item(name: 'Sushi', quantity: 3),
    Item(name: 'Tempura', quantity: 2),
    Item(name: 'Pasta', quantity: 1),
    Item(name: 'Salad', quantity: 1),
    Item(name: 'Soup', quantity: 1),
    Item(name: 'Pasta', quantity: 1),
    Item(name: 'Salad', quantity: 1),
    Item(name: 'Soup', quantity: 1),
  ]),
];
