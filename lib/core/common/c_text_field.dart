import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_task/core/common/colors.dart';
import 'package:host_task/core/common/label.dart';



enum CustomTextInputType { text, email, number, password, alphanumeric }

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextInputAction? textInputAction;
  final CustomTextInputType inputType;
  final TextEditingController controller;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final ScrollPhysics? scrollPhysics;
  final Color? cursorColor;
  final EdgeInsets scrollPadding;
  final bool enabled;
  final bool autoFocus;
  final TextAlign textAlign;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? borderColor;
  final Color? backGroundColor;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.textInputAction = TextInputAction.none,
    this.inputType = CustomTextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.scrollPhysics,
    this.cursorColor,
    this.scrollPadding = EdgeInsets.zero,
    this.enabled = true,
    this.autoFocus = false,
    this.textAlign = TextAlign.start,
    this.height,
    this.width,
    this.borderRadius,
    this.borderColor,
    this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordEyeBloc(),
      child: BlocBuilder<PasswordEyeBloc, bool>(
        builder: (context, flag) {
          return Theme.of(context).platform == TargetPlatform.iOS
              ? _buildCupertinoTextField(context, flag)
              : _buildMaterialTextField(context, flag);
        },
      ),
    );
  }

  Widget _buildCupertinoTextField(BuildContext context, bool eyeVisible) {
    final screenSize = MediaQuery.of(context).size;
    const double minHeight = 42.0;
    controller.addListener(() {
      if (validator != null) {
        validator!(controller.text);
      }
    });

    return SizedBox(
      height: (screenSize.height * 0.050).clamp(minHeight, double.infinity),
      width: screenSize.width * 0.277,
      child: CupertinoTextField(
        textInputAction: textInputAction,
        controller: controller,
        placeholder: hintText,
        keyboardType: _getCupertinoKeyboardType(),
        obscureText:
            inputType == CustomTextInputType.password ? !eyeVisible : false,
        obscuringCharacter: '*',
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
            border: Border.all(
                color: borderColor ?? AppColors.secondaryColor, width: 1.51),
            color: backGroundColor),
        scrollPhysics: scrollPhysics,
        cursorColor: cursorColor,
        scrollPadding: scrollPadding,
        enabled: enabled,
        autofocus: autoFocus,
        textAlign: textAlign,
        suffix: obscureText
            ? GestureDetector(
                onTap: () {
                  context.read<PasswordEyeBloc>().togglePasswordEye();
                  onChanged?.call('toggle');
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: Icon(
                    eyeVisible
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                    color: AppColors.iconColor,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildMaterialTextField(BuildContext context, bool eyeVisible) {
    final screenSize = MediaQuery.of(context).size;
    const double minHeight = 42.0;
    const double minWidth = 200.0;

    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: BorderRadius.circular(10)),
      height: (screenSize.height * 0.050).clamp(minHeight, double.infinity),
      width: (screenSize.width * 0.22).clamp(minWidth, double.infinity),
      child: TextFormField(
        textInputAction: textInputAction,
        style: const TextStyle(
            fontFamily: CustomLabels.primaryFont,
            color: AppColors.newTextColor,
            fontSize: 14),
        controller: controller,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          errorStyle: const TextStyle(fontSize: .1),
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(
              fontFamily: CustomLabels.primaryFont,
              color: AppColors.newTextColor,
              fontSize: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: .5,
              color: borderColor ?? AppColors.iconColor.withOpacity(.2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: .5,
              color: borderColor ?? AppColors.iconColor.withOpacity(.2),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          suffixIcon: inputType == CustomTextInputType.password
              ? GestureDetector(
                  onTap: () {
                    context.read<PasswordEyeBloc>().togglePasswordEye();
                    onChanged?.call('toggle');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Icon(
                      eyeVisible
                          ? Icons.visibility
                          : Icons.visibility_off_outlined,
                      color: AppColors.secondaryColor,
                      size: 20,
                    ),
                  ),
                )
              : null,
        ),
        keyboardType: _getMaterialKeyboardType(),
        obscureText:
            inputType == CustomTextInputType.password ? !eyeVisible : false,
        onChanged: (value) {
          if (validator != null) {
            validator!(value);
          }
        },
        onFieldSubmitted: onSubmitted,
        // validator: (value){
        //    if(validator!=null) {
        //      validator!(value);
        //    }
        //
        //   if(value=="")return "";
        //   return null;
        // },
        scrollPhysics: scrollPhysics,
        cursorColor: cursorColor,
        scrollPadding: scrollPadding,
        enabled: enabled,
        autofocus: autoFocus,
        textAlign: textAlign,
      ),
    );
  }

  TextInputType _getCupertinoKeyboardType() {
    switch (inputType) {
      case CustomTextInputType.email:
        return TextInputType
            .text; // No specific email keyboard in CupertinoTextField
      case CustomTextInputType.number:
        return const TextInputType.numberWithOptions(decimal: true);
      default:
        return TextInputType.text;
    }
  }

  TextInputType _getMaterialKeyboardType() {
    switch (inputType) {
      case CustomTextInputType.email:
        return TextInputType.emailAddress;
      case CustomTextInputType.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}

class PasswordEyeBloc extends Cubit<bool> {
  bool currentStatus = false;
  PasswordEyeBloc() : super(false) {
    currentStatus = false;
  }

  void togglePasswordEye() {
    currentStatus = !currentStatus;
    emit(currentStatus);
  }
}
