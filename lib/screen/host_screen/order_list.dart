import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_task/screen/host_screen/cubits/ready_data/get_data_cubit.dart';

import '../../core/common/colors.dart';

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
            // Expanded(
            //   child:
            // ),
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: orders2.map((order) => OrderCard(order: order))
                      .toList(),
                ),
              ),
            ),
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
  final Order order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(10.0),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15),
      // ),
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
            const Row(
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
                  "233444",
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
            const Row(
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
                  "12",
                  style: TextStyle(
                    color: AppColors.newTextColor,
                    fontSize: 18,
                  ),
                  minFontSize: 14,
                  maxFontSize: 18,
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = order.items[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 7.0),
                      child: Text(
                        item.quantity.toString(),
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
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              dropdownColor: Colors.white,
              value: "Ready",
              items: _dropDownItem(),
              onChanged: (value) {
                print(value);
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
List<Order> orders1 = [
  Order(orderNo: 1, tableNo: 101, items: [
    Item(name: 'Pizza', quantity: 1),
  ]),
  Order(orderNo: 2, tableNo: 102, items: [
    Item(name: 'Burger', quantity: 2),
    Item(name: 'Fries', quantity: 1),
  ]),
  Order(orderNo: 3, tableNo: 103, items: [
    Item(name: 'Pasta', quantity: 1),
    Item(name: 'Salad', quantity: 1),
    Item(name: 'Soup', quantity: 1),
    Item(name: 'Sushi', quantity: 3),
    Item(name: 'Tempura', quantity: 2),
  ]),
  Order(orderNo: 3, tableNo: 103, items: [
    Item(name: 'Pasta', quantity: 1),
    Item(name: 'Salad', quantity: 1),
    Item(name: 'Soup', quantity: 1),
    Item(name: 'Sushi', quantity: 3),
    Item(name: 'Tempura', quantity: 2),
    Item(name: 'Burger', quantity: 2),
    Item(name: 'Fries', quantity: 1),
    Item(name: 'Burger', quantity: 2),
    Item(name: 'Fries', quantity: 1),
    Item(name: 'Burger', quantity: 2),
    Item(name: 'Fries', quantity: 1),
    Item(name: 'Burger', quantity: 2),
    Item(name: 'Fries', quantity: 1),
  ]),
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
