import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:host_task/core/images/image.dart';
import 'package:host_task/screen/common/common_search_bar.dart';
import 'package:host_task/screen/host_screen/cubits/ready_data/get_data_cubit.dart';
import 'package:host_task/screen/host_screen/cubits/search_cubit.dart';
import '../../core/auth/cubits/get_user_details/get_user_details_cubit.dart';
import '../../core/auth/cubits/logout/logout_cubit.dart';
import '../../core/auth/presentation/login_screen.dart';
import '../../core/common/colors.dart';
import '../../core/common/label.dart';
import '../common/common_list.dart';
import '../model/order_model.dart';
import 'cubits/change_language/change_language_cubit.dart';
import 'cubits/check_status/check_status_cubit.dart';
import 'cubits/delivered_Data/fetch_prepared_data_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

String? selectedLanguage = "English";
Locale? selectLanguage = Locale('en');
enum Language { english, arabic }

List<OrderModel> readyOrders = [];
List<OrderModel> filteredReadyOrders = [];
List<OrderModel> tempOrders = [];

class OrderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.scolor,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AppImage.appLogo1,
            height: 50,
            width: 150,
            fit: BoxFit.fill,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 10),
            child: Row(
              children: [
                CommonSearchBar(),
                SizedBox(
                  width: 10,
                ),
                const Icon(
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
                          style: const TextStyle(color: AppColors.newTextColor),
                        );
                      }
                      if (state is GetUserDetailsErrorState) {
                        return Text(state.errorName);
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                BlocConsumer<LogoutCubit, LogoutState>(
                  listener: (context, state) {
                    if (state is LogoutSuccessState) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (Route route) => false);
                    }
                    if (state is LogoutErrorState) {
                      print("Logout Failed.......");
                    }
                  },
                  builder: (context, state) {
                    return BlocBuilder<ChangeLanguageCubit,
                        ChangeLanguageState>(
                      builder: (context, state) {
                        Locale? languageName;
                        languageName = selectLanguage;
                        if(state is ChangeLanguageSuccess){
                          languageName = state.name;
                        }
                        return PopupMenuButton(
                            position: PopupMenuPosition.under,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.black,
                              size: 20,
                            ),
                            color: AppColors.whiteColor,
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
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.logout,
                                              color: AppColors.newTextColor,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              languageName ==   Locale('ar') ? "تسجيل خروج":"Logout",
                                              style: TextStyle(
                                                color: AppColors.darkColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ]);
                      },
                    );
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
                                child: Text('Arabic'),
                              ),
                            ]);
                  },
                )
              ],
            ),
          )
        ],
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchSuccessState) {
            filteredReadyOrders = state.searchList;
          }
          return BlocBuilder<GetDataCubit, GetDataState>(
            builder: (context, state) {
              if (state is GetPlacedDataLoadedState) {
                readyOrders = state.readyList;

                if (filteredReadyOrders.isEmpty) {
                  tempOrders = readyOrders;
                } else {
                  tempOrders = filteredReadyOrders;
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: tempOrders.length,
                    itemBuilder: (BuildContext context, int index) =>
                        OrderCard(order: tempOrders[index]),
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                );
              } else if (state is GetDataLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text('No orders available'));
              }
            },
          );
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    var optionName = AppLocalizations.of(context);
    return Card(
      elevation: 4,
      shadowColor: AppColors.darkColor,
      color: Colors.white,
      margin: EdgeInsets.all(10.0),
      child: Container(
        width: 100, // Adjust the width as needed
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AutoSizeText(
                  "${optionName!.orderno}:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  minFontSize: 14,
                  maxFontSize: 18,
                ),
                AutoSizeText(
                  order.orderId.toString(),
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
            Row(
              children: [
                AutoSizeText(
                  "${optionName!.tableno}: ",
                  style: TextStyle(
                    color: AppColors.buttonColor,
                    fontSize: 18,
                  ),
                  minFontSize: 14,
                  maxFontSize: 18,
                ),
                AutoSizeText(
                  order.tableNo.toString(),
                  style: TextStyle(
                    color: AppColors.buttonColor,
                    fontSize: 18,
                  ),
                  minFontSize: 14,
                  maxFontSize: 18,
                ),
              ],
            ),
            AutoSizeText(
              "${optionName!.orderItems}: ",
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
                    AutoSizeText(
                      item!.name!,
                      style: const TextStyle(
                        color: AppColors.iconColor,
                        fontSize: 15,
                      ),
                      minFontSize: 14,
                      maxFontSize: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 7.0),
                      child: AutoSizeText(
                        item!.quatity!.toString(),
                        style: const TextStyle(
                          color: AppColors.iconColor,
                          fontSize: 15,
                        ),
                        minFontSize: 14,
                        maxFontSize: 18,
                      ),
                    ),
                  ],
                );
              },
            ),
            BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
              builder: (context, state) {
                Locale name = Locale("en");
                if (state is ChangeLanguageSuccess) {
                  print("labguagauge =${state.name}");
                  name = state.name!;
                }
                return DropdownButtonFormField(
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  dropdownColor: Colors.white,
                  value: status,
                  items: (name == Locale('ar'))
                      ? _dropDownItemArabic()
                      : _dropDownItem(),
                  onChanged: (value) {
                    print(value);
                    status = value!;

                    id = order.orderId.toString();

                    BlocProvider.of<CheckStatusCubit>(context)
                        .CheckStatusData();

                    BlocProvider.of<GetDataCubit>(context).fetchReadyData();
                  },
                  onTap: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> _dropDownItem() {
  List<String> itemValue = ["Ready", "Delivered"];
  return itemValue
      .map((value) => DropdownMenuItem(value: value, child: Text(value)))
      .toList();
}

List<DropdownMenuItem<String>> _dropDownItemArabic() {
  List<String> itemValue = ["تم وضعه", "خطة", "مستعد"];

  return itemValue
      .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();
}
