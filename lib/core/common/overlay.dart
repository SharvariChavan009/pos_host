import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../../core/common/custom_snackbar.dart';


class OverlayManager {
  static void showSnackbar(BuildContext context, {required ContentType type, required String title, required String message}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (BuildContext context) => CustomSnackbar(
        type: type,
        title: title,
        message: message,
      ),
    );
    overlay.insert(overlayEntry);
    Future.delayed(const Duration(milliseconds: 2000), () {
      overlayEntry.remove();
    });
  }
}
