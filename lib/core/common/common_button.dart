// import 'package:flutter/material.dart';
// import 'package:pos_application/core/common/ui_helper.dart';
// import 'colors.dart';
// import 'icon.dart';
//
// class CommonButton extends StatefulWidget {
//   final TextStyle? textStyle;
//   final Function onPressed;
//   final String title;
//   final String image;
//   final Color? backgroundColor;
//   final Color? borderColor;
//   final BoxShadow? shadow;
//   final Color? titleColor;
//   final Color? imageColor;
//   final double? width;
//   final double? height;
//   final bool isIcon;
//   final bool isImage;
//   final Color? iconColor;
//   final bool? isLoading;
//   final EdgeInsetsGeometry? edgeInsetsGeometry;
//   final BorderRadiusGeometry? borderRadius;
//   final BorderRadius? mainBorderRadius;
//   const CommonButton({
//     required this.onPressed,
//     required this.title,
//     this.shadow,
//     this.textStyle,
//     this.borderColor = Colors.transparent,
//     this.backgroundColor = AppColors.buttonColor,
//     // CustomStyles.primaryTextColor,
//     this.edgeInsetsGeometry,
//     this.height,
//     this.width,
//     this.image = "",
//     this.imageColor = AppColors.whiteColor,
//     this.titleColor = AppColors.whiteColor,
//     this.iconColor,
//     this.isIcon = false,
//     this.isImage = false,
//     this.isLoading = false,
//     this.borderRadius,
//     this.mainBorderRadius,
//     super.key,
//   });
//
//   @override
//   State<CommonButton> createState() => _CommonButtonState();
// }
//
// class _CommonButtonState extends State<CommonButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: (widget.edgeInsetsGeometry == null)
//           ? EdgeInsets.zero
//           : widget.edgeInsetsGeometry,
//       decoration: BoxDecoration(
//         color: widget.backgroundColor,
//         borderRadius: widget.mainBorderRadius ?? BorderRadius.circular(26),
//         border: Border.all(color: widget.borderColor!, width: 1),
//       ),
//       child: SizedBox(
//         width: widget.width ?? (MediaQuery.of(context).size.width - 60),
//         height: widget.height ?? 51,
//         child: Material(
//           color: widget.backgroundColor,
//           surfaceTintColor: Colors.red,
//           borderRadius: widget.borderRadius ?? BorderRadius.circular(26),
//           child: InkWell(
//             borderRadius: widget.mainBorderRadius ?? BorderRadius.circular(26),
//             splashColor: AppColors.darkColor,
//             onTap: () {
//               widget.onPressed();
//             },
//             child: Padding(
//               padding: widget.isImage
//                   ? const EdgeInsets.symmetric(horizontal: 7)
//                   : widget.isIcon
//                       ? const EdgeInsets.symmetric(horizontal: 7)
//                       : const EdgeInsets.symmetric(horizontal: 0),
//               child: widget.isLoading ?? false
//                   ? Container(
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.red, width: 31)),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Text("${widget.title} d", style: widget.textStyle),
//                         ],
//                       ),
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         widget.isImage
//                             ? Row(
//                                 children: [
//                                   const SizedBox(
//                                     width: 5,
//                                   )
//                                 ],
//                               )
//                             : const SizedBox.shrink(),
//                         Text(widget.title,
//                             style: widget.textStyle ??
//                                 CustomStyles.elebtnTextStyle()),
//                         widget.isIcon
//                             ? const SizedBox(
//                                 width: 5,
//                               )
//                             : const SizedBox.shrink(),
//                         widget.isIcon
//                             ? Icon(
//                                 Icons.arrow_forward,
//                                 color: widget.iconColor ?? Colors.white,
//                                 size: 20,
//                               )
//                             : const SizedBox.shrink()
//                       ],
//                     ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
