import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_task/core/common/colors.dart';
import 'package:host_task/screen/common/common_list.dart';
import 'package:host_task/screen/host_screen/cubits/check_status/check_status_cubit.dart';
import 'package:host_task/screen/host_screen/cubits/delivered_Data/fetch_prepared_data_cubit.dart';
import 'package:host_task/screen/host_screen/cubits/ready_data/get_data_cubit.dart';

class HostScreen extends StatefulWidget {
  const HostScreen({super.key});

  @override
  State<HostScreen> createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  // ------------------------------
  List<String> selectedItemValue = []; // ready

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> itemValue = ["Ready", "Delivered"];

    return itemValue
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

//-------------------------------
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print("Screen Height: $screenHeight");
    print("Screen Width: $screenWidth");

//-------------------------------
    return Scaffold(
      backgroundColor: AppColors.scolor,
      appBar: AppBar(
        backgroundColor: AppColors.scolor,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/image/qd_logo.webp",
            height: 60,
            width: 150,
            fit: BoxFit.fill,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              size: 30,
              Icons.notifications,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 10),
            child: SizedBox(
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        isRepeatingAnimation: true,
                        animatedTexts: [
                          TyperAnimatedText('Ready To Serve'),
                          TyperAnimatedText('Collect The Order..'),
                        ],
                      ),
                    ),
                  ),
                  BlocConsumer<GetDataCubit, GetDataState>(
                    listener: (context, state) {
                      if (state is GetAllDataErrorState) {
                        print(state);
                      }
                    },
                    builder: (context, state) {
                      print(state);

                      if (state is GetPlacedDataLoadedState) {
                        print(state);

                        return Container(
                          height: screenHeight * 0.28,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.readyList.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                for (int i = 0; i < 2; i++) {
                                  selectedItemValue.add("Ready");
                                }

                                var orderdata = state.readyList[index];
                                // print(" Order Name: ${orderdata.items![index].name}");

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: AppColors.newCardBackgroundColor,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.newCardBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      width: screenWidth * 0.30,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Order No: ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    orderdata.orderNo
                                                        .toString(),
                                                    // state.orderList[index].orderNo.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0, bottom: 5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Table No: ",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .newTextColor,
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    orderdata.tableNo
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .newTextColor,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  orderdata.items!.length,
                                              itemBuilder: (context, index1) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      orderdata
                                                          .items![index1].name
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .newTextColor,
                                                          fontSize: 18),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 7.0),
                                                      child: Text(
                                                        orderdata.items![index1]
                                                            .quatity!
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .newTextColor,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.scolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0, right: 2),
                                                  child: SizedBox(
                                                    child: BlocBuilder<
                                                            CheckStatusCubit,
                                                            CheckStatusState>(
                                                          builder:
                                                              (context, state) {
                                                            return DropdownButtonFormField(
                                                              decoration: InputDecoration(
                                                                  enabledBorder:
                                                                      UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.white))),
                                                              dropdownColor:
                                                                  Colors.white,
                                                              value:
                                                                  selectedItemValue[
                                                                      index],
                                                              items:
                                                                  _dropDownItem(),
                                                              onChanged:
                                                                  (value) {
                                                                status =
                                                                    selectedItemValue[
                                                                            index] =
                                                                        value!;

                                                                id = orderdata
                                                                    .orderId
                                                                    .toString();

                                                                setState(() {
                                                                  print(
                                                                      '<< Host Selected Id: $id and value: $status >>');
                                                                });

                                                                BlocProvider.of<
                                                                            CheckStatusCubit>(
                                                                        context)
                                                                    .CheckStatusData();

                                                                BlocProvider.of<
                                                                            GetDataCubit>(
                                                                        context)
                                                                    .fetchPlacedlData();
                                                              },

                                                          
                                                            );
                                                          },
                                                        ),
                                                     
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
