import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon extends StatelessWidget {
  final Color? color;
  final String iconPath;
  final double size;
  const CustomIcon({
    Key? key,
    this.color,
    required this.iconPath,
    this.size = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      height: 25,
      width: 22,
    );
  }
}
