import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final ContentType? type;
  final String? message;
  final String? title;
  const CustomSnackbar(
      {super.key,
      required this.type,
      required this.message,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      elevation: 0,
      backgroundColor: Colors.transparent,
      dividerColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: title!,
        message: message!,
        contentType: type!,
        inMaterialBanner: true,
      ),
      actions: const [SizedBox.shrink()],
    );
  }
}
