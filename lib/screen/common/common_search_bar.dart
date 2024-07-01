

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/common/colors.dart';
import '../host_screen/cubits/search_cubit.dart';

late String val;

class CommonSearchBar extends StatefulWidget {
  const CommonSearchBar({
    super.key,
  });

  @override
  State<CommonSearchBar> createState() => _CommonSearchBarState();
}

class _CommonSearchBarState extends State<CommonSearchBar> {


  @override
  Widget build(BuildContext context) {
var swidth = MediaQuery.of(context).size.width;
print("swidth $swidth");
    return Container(
      width: swidth*0.13,
        child:TextFormField(
      onChanged: (value) {
        val = value;
        BlocProvider.of<SearchCubit>(context).searchFunctio(val);
        // BlocProvider.of<TenantsearchCubit>(context).searchFunctio(val);
      },
      style: const TextStyle(color: AppColors.darkColor, fontSize: 14),
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.iconColor,
          size: 20,
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(.2),
        hintText: "Search with Table no",
        hintStyle: const TextStyle(fontSize: 14, color: AppColors.iconColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white, width: 0.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white, width: 0.2),
        ),
      ),
      keyboardType: TextInputType.text,
    ));
  }
}
