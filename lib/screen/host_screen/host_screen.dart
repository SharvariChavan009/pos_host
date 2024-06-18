import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:host_task/core/auth/cubits/get_user_details/get_user_details_cubit.dart';
import 'package:host_task/core/auth/cubits/logout/logout_cubit.dart';
import 'package:host_task/core/auth/presentation/login_screen.dart';
import 'package:host_task/core/common/colors.dart';
import 'package:host_task/core/common/label.dart';
import 'package:host_task/screen/common/common_list.dart';
import 'package:host_task/screen/host_screen/cubits/change_language/change_language_cubit.dart';
import 'package:host_task/screen/host_screen/cubits/check_status/check_status_cubit.dart';
import 'package:host_task/screen/host_screen/cubits/delivered_Data/fetch_prepared_data_cubit.dart';
import 'package:host_task/screen/host_screen/cubits/ready_data/get_data_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

enum Language { english, arabic }

class HostScreen extends StatefulWidget {
  const HostScreen({super.key});

  @override
  State<HostScreen> createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  // ------------------------------

    var ordernum;


  List<String> selectedItemValue = []; // ready

  String? selectedLanguage = "English";

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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 10),
            child: Row(
              children: [
                Icon(
                  size: 25,
                  Icons.notifications,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0, left: 10),
                  child: BlocBuilder<GetUserDetailsCubit, GetUserDetailsState>(
                    builder: (context, state) {
                      if (state is GetUserDetailsSuccessState) {
                        return Text(
                          state.userName,
                          style: TextStyle(color: AppColors.newTextColor),
                        );
                      }
                      if (state is GetUserDetailsErrorState) {
                        return Text(state.errorName);
                      }
                      return SizedBox();
                    },
                  ),
                ),
                BlocConsumer<LogoutCubit, LogoutState>(
                  listener: (context, state) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route route) => false);
                  },
                  builder: (context, state) {
                    return PopupMenuButton(
                        position: PopupMenuPosition.under,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.black,
                          size: 20,
                        ),
                        color: AppColors.newCardBackgroundColor,
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  onTap: () {},
                                  textStyle: const TextStyle(
                                    color: AppColors.newTextColor,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      BlocProvider.of<LogoutCubit>(context)
                                          .logout();
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.logout,
                                          color: AppColors.newTextColor,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                            color: AppColors.newTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ]);
                  },
                ),
                Text(
                  selectedLanguage!,
                  style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 14,
                    fontFamily: CustomLabels.primaryFont,
                  ),
                ),
                BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
                  builder: (context, state) {
                    return PopupMenuButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppColors.iconColor,
                          size: 20,
                        ),
                        onSelected: (Language value) {
                          // selectedLanguage = "$value";
                          if (Language.english.name == value.name) {
                            selectedLanguage = "English";
                            BlocProvider.of<ChangeLanguageCubit>(context)
                                .ChangelanguageFunction(Locale('en'));

                            print("Selected Language: ${value.name}");
                          } else {
                            selectedLanguage = "عربي";
                            BlocProvider.of<ChangeLanguageCubit>(context)
                                .ChangelanguageFunction(Locale('ar'));

                            print("Selected Language: ${value.name}");
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<Language>>[
                              const PopupMenuItem(
                                value: Language.english,
                                child: Text('English'),
                              ),
                              const PopupMenuItem(
                                value: Language.arabic,
                                child: Text('arabic'),
                              ),
                            ]);
                  },
                )
              ],
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
                          TyperAnimatedText(
                              '${AppLocalizations.of(context)!.readyToServe} '),
                          TyperAnimatedText(
                              '${AppLocalizations.of(context)!.collectTheOrder}..'),
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
                                print(" Order Name: ${orderdata.items![index].name}");
                                 return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: AppColors.newCardBackgroundColor,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors
                                                  .newCardBackgroundColor,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  child: Row(
                                                    children: [
                                                      AutoSizeText(
                                                        "${AppLocalizations.of(context)!.orderno}: ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                        minFontSize: 14,
                                                        maxFontSize: 18,
                                                      ),
                                                      AutoSizeText(
                                                        orderdata.orderNo
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 18),
                                                        minFontSize: 14,
                                                        maxFontSize: 18,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    AutoSizeText(
                                                      "${AppLocalizations.of(context)!.tableno}: ",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .newTextColor,
                                                          fontSize: 18),
                                                      minFontSize: 14,
                                                      maxFontSize: 18,
                                                    ),
                                                    AutoSizeText(
                                                      orderdata.tableNo
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .newTextColor,
                                                          fontSize: 18),
                                                      minFontSize: 14,
                                                      maxFontSize: 18,
                                                    ),
                                                  ],
                                                ),

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    AutoSizeText(
                                                      orderdata.items![0].name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .newTextColor,
                                                          fontSize: 18),
                                                      minFontSize: 14,
                                                      maxFontSize: 18,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 7.0),
                                                      child: AutoSizeText(
                                                        orderdata
                                                            .items![0].quatity
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .newTextColor,
                                                            fontSize: 18),
                                                        minFontSize: 14,
                                                        maxFontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                //------- View More --------------

                                                state.readyList[index].items!
                                                            .length >
                                                        1
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          GestureDetector(
                                                            child:
                                                                 AutoSizeText(
                                                              "${AppLocalizations.of(context)!.viewmore} ",
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  decorationColor:
                                                                      AppColors
                                                                          .secondaryColor,
                                                                  color: AppColors
                                                                      .secondaryColor,
                                                                  fontSize: 14),
                                                              minFontSize: 12,
                                                              maxFontSize: 14,
                                                            ),
                                                            onTap: () {
                                                              ordernum = orderdata
                                                                  .orderNo
                                                                  .toString();

                                                              showDialog(
                                                                barrierDismissible:
                                                                    true,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  var screenSize =
                                                                      MediaQuery.of(
                                                                              context)
                                                                          .size;
                                                                  return Dialog(
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .newCardBackgroundColor,
                                                                    child:
                                                                        SizedBox(
                                                                      width: screenSize
                                                                              .width *
                                                                          0.3, // 80% of screen width
                                                                      height: screenSize
                                                                              .height *
                                                                          0.5, // 50% of screen height

                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                AppColors.newCardBackgroundColor,
                                                                            borderRadius: BorderRadius.circular(15)),
                                                                        height: screenHeight *
                                                                            0.50,
                                                                        width: screenWidth *
                                                                            0.25,
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              top: 20.0,
                                                                              bottom: 8,
                                                                              right: 10,
                                                                              left: 10),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(bottom: 25.0),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                     Text(
                                                                                      "${AppLocalizations.of(context)!.orderno}: ",
                                                                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                                                                                    ),
                                                                                    Text(
                                                                                      ordernum,
                                                                                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              ListView.builder(
                                                                                  shrinkWrap: true,
                                                                                  itemCount: orderdata.items!.length,
                                                                                  itemBuilder: (context, index1) {
                                                                                    return Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        AutoSizeText(
                                                                                          orderdata.items![index1].name.toString(),
                                                                                          style: const TextStyle(color: AppColors.newTextColor, fontSize: 18),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(right: 7.0),
                                                                                          child: AutoSizeText(
                                                                                            orderdata.items![index1].quatity.toString(),
                                                                                            style: const TextStyle(color: AppColors.newTextColor, fontSize: 18),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  }),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      )
                                                    : Container(),

                                                //--------------------------------

                                                Padding(
                                                  padding: state
                                                              .readyList[index]
                                                              .items!
                                                              .length ==
                                                          1
                                                      ? const EdgeInsets.only(
                                                          top: 26.0,
                                                        )
                                                      : const EdgeInsets.only(
                                                          top: 5.0,
                                                        ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColors.scolor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 2.0,
                                                              right: 2),
                                                      child: SizedBox(
                                                        child: BlocBuilder<
                                                            CheckStatusCubit,
                                                            CheckStatusState>(
                                                          builder:
                                                              (context, state) {
                                                            return DropdownButtonFormField(
                                                              decoration: const InputDecoration(
                                                                  enabledBorder:
                                                                      UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.transparent))),
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

                                                                BlocProvider.of<
                                                                            CheckStatusCubit>(
                                                                        context)
                                                                    .CheckStatusData();

                                                                BlocProvider.of<
                                                                            GetDataCubit>(
                                                                        context)
                                                                    .fetchPlacedlData();

                                                                BlocProvider.of<
                                                                            FetchPreparedDataCubit>(
                                                                        context)
                                                                    .fetchPreparedlData();

                                                           

                                                                setState(() {
                                                                  print(
                                                                      '<< Placed Selected Index: $index and value: $value >>');
                                                                });
                                                              },
                                                              onTap: () {},
                                                              // hint: Text('0'),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
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
