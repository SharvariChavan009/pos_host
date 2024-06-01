import 'package:flutter/material.dart';
import 'package:host_task/core/common/colors.dart';
import 'package:host_task/core/common/label.dart';


class CommonTextFormField extends StatelessWidget {
  final String text;
  final void Function(String)? onchange;
  final bool obscureText;
  final TextEditingController? controller;
  const CommonTextFormField({
    super.key,
    required this.text,
    this.onchange,
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 30,
      child: TextFormField(
        onChanged: onchange,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8.0),
          border: const OutlineInputBorder(),
          labelText: text,
          labelStyle: CustomLabels.regularTextStyle(
              fontSize: CustomLabels.extraSmallFontSize,
              color: AppColors.darkColor),
        ),
        style: CustomLabels.regularTextStyle(
            fontSize: CustomLabels.extraSmallFontSize,
            color: AppColors.darkColor),
      ),
    );
  }
}
