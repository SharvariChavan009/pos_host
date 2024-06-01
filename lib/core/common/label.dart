import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:host_task/core/common/colors.dart';



class CustomLabels {
  static const double extraSmallFontSize = 12;
  static const double verySmallFontSize = 13;
  static const double smallFontSize = 16;
  static const double mediumFontSize = 23;
  static const double largeFontSize = 26;
  static const double veryLargeFontSize = 28;
  static const double extraLargeFontSize = 32;

  static const verySmallFontWeight = FontWeight.w400;
  static const smallFontWeight = FontWeight.w500;
  static const mediumFontWeight = FontWeight.w600;
  static const largeFontWeight = FontWeight.w700;
  static const String primaryFont = "Urbanist";
  static const String secondaryFont = "Work Sans";

  /// This is for headers
  static TextStyle headerTextStyle({
    double fontSize = extraLargeFontSize,
    FontWeight fontWeight = largeFontWeight,
    Color color = AppColors.whiteColor,
    String fontFamily = primaryFont,
    double letterSpacing = .2,
    double height = 1.4,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// This is for Titles

  static TextStyle titlesTextStyle({
    double fontSize = mediumFontSize,
    FontWeight fontWeight = largeFontWeight,
    Color color = AppColors.whiteColor,
    String fontFamily = primaryFont,
    double letterSpacing = .2,
    double height = 1.4,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle regularTextStyle({
    double fontSize = smallFontSize,
    FontWeight fontWeight = CustomLabels.mediumFontWeight,
    Color color = AppColors.whiteColor,
    String fontFamily = primaryFont,
    double letterSpacing = 0,
    // double height = 1.2,
  }) {
    return GoogleFonts.getFont(
      fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      // height: height,
    );
  }

  ///
  static TextStyle textTextStyle({
    double fontSize = smallFontSize,
    FontWeight fontWeight = CustomLabels.smallFontWeight,
    Color color = AppColors.secondaryColor,
    String fontFamily = CustomLabels.primaryFont,
    double letterSpacing = 0,
    double height = 1.2,
  }) {
    return GoogleFonts.getFont(
      fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle subTitlesTextStyle({
    double fontSize = smallFontSize,
    FontWeight fontWeight = largeFontWeight,
    Color color = AppColors.whiteColor,
    String fontFamily = primaryFont,
    double letterSpacing = .2,
    double height = 1.4,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// This is for Body

  static TextStyle bodyTextStyle(
      {double fontSize = mediumFontSize,
      FontWeight fontWeight = largeFontWeight,
      Color color = AppColors.whiteColor,
      String fontFamily = primaryFont,
      double letterSpacing = 0.2,
      double height = 1.4,
      TextDecoration decoration = TextDecoration.none}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle body1TextStyle({
    double fontSize = smallFontSize,
    FontWeight fontWeight = largeFontWeight,
    Color color = AppColors.whiteColor,
    String fontFamily = primaryFont,
    double letterSpacing = .2,
    double height = 1.4,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// This is for Caption

  static TextStyle captionTextStyle(
      {double fontSize = smallFontSize,
      FontWeight fontWeight = largeFontWeight,
      Color color = AppColors.whiteColor,
      String fontFamily = primaryFont,
      double letterSpacing = 0.2,
      double height = 1.4,
      TextDecoration decoration = TextDecoration.none}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: TextDecoration.none,
    );
  }

  /// This is for Button

  static TextStyle buttonTextStyle(
      {double fontSize = verySmallFontSize,
      FontWeight fontWeight = mediumFontWeight,
      Color color = AppColors.whiteColor,
      String fontFamily = primaryFont,
      double letterSpacing = 0.2,
      double height = 1.4,
      TextDecoration decoration = TextDecoration.none}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: TextDecoration.none,
    );
  }
}
