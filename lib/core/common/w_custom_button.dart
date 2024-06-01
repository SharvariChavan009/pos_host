import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:host_task/core/common/colors.dart';
import 'package:host_task/core/common/label.dart';


class CustomButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final String? imagePath;
  final Color? textColor;
  final Color? backgroundColor; // New
  final Color? activeButtonColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? height;
  final double? minWidth;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final VoidCallback? onPressed;
  final bool? isEnabled;
  final TextStyle? textStyle;
  final double? borderRadius;

  const CustomButton({
    super.key,
    this.text,
    this.icon,
    this.imagePath,
    this.textColor,
    this.backgroundColor = AppColors.primaryColor, // New
    this.borderColor = AppColors.primaryColor,
    this.activeButtonColor = AppColors.primaryColor,
    this.borderWidth,
    this.height,
    this.minWidth,
    this.padding,
    this.elevation,
    this.onPressed,
    this.isEnabled = true,
    this.textStyle,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return isIOS
        ? _buildCupertinoButton(context)
        : _buildMaterialButton(context);
  }

  Widget _buildCupertinoButton(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    // const double minHeight = 42.0;
    const double minWidth = 200.0;
    // final sizes = Sizes(context);

    return Container(
      height:
          40, //(screenSize.height * 0.010).clamp(minHeight, double.infinity),
      width: 200, //sizes.buttonWidth.clamp(minWidth, double.infinity),
      decoration: BoxDecoration(
        color: isEnabled! ? activeButtonColor : backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius!),
        border: Border.all(color: borderColor ?? AppColors.primaryColor),
      ),
      child: CupertinoButton(
        onPressed: isEnabled! ? onPressed : null,
        borderRadius: BorderRadius.circular(10),
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        minSize: minWidth,
        pressedOpacity: .1,
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildMaterialButton(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const double minHeight = 42.0;
    // const double minHeight = 33.0;
    const double minWidth = 200.0;
    // final sizes = Sizes(context);

    return MaterialButton(
      disabledColor: backgroundColor,
      onPressed: isEnabled! ? onPressed : null,
      color: isEnabled! ? activeButtonColor : backgroundColor,
      textColor: textColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: borderColor ?? AppColors.primaryColor,
            width: borderWidth ?? 0),
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
      elevation: elevation ?? 0,
      height: (screenSize.height * 0.050).clamp(minHeight, double.infinity),
      minWidth: (screenSize.width * 0.22).clamp(minWidth, double.infinity),
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    final List<Widget> children = [];

    if (imagePath != null) {
      children.add(
        Image.asset(
          imagePath!,
          width: 22,
          height: 22,
        ),
      );
      children.add(
        const SizedBox(width: 8.0),
      );
    }

    if (text != null) {
      children.add(
        Text(
          text!,
          style: textStyle ?? CustomLabels.buttonTextStyle(),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
