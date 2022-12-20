import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Style {
  Style._();

  // ------------------Color------------------//
  static const whiteColor = Color(0xffFFFFFF);
  static const blackColor = Color(0xff000000);
  static const primaryColor = Color(0xff1B1C1F);
  static const brandColor =Color(0xff24A19C);
  static const successColor =Color(0xff17A1A1);
  static const errorColor =Color(0xffFF486A);
  static const warningColor =Color(0xffFD8311);
  static const transparent = Colors.transparent;

// ------------------Gradient------------------//
  static const primaryGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        successColor,
        brandColor,
      ]);

  static const disableGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0x5017A1A1),
        Color(0x5024A19C),
      ]);

// ------------------text style------------------//
  static textStyleNormal(
      {double size = 16, Color textColor = primaryColor, bool isDone = false}) {
    return GoogleFonts.poppins(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.normal,
      decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none);
  }

  static textStyleSemiBold(
      {double size = 16, Color textColor = primaryColor, bool isDone = false}) {
    return GoogleFonts.poppins(
        fontSize: size,
        color: textColor,
        fontWeight: FontWeight.w600,
        decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none);
  }

  static textStyleBold(
      {double size = 18, Color textColor = primaryColor, bool isDone = false}) {
    return GoogleFonts.poppins(
        fontSize: size,
        color: textColor,
        fontWeight: FontWeight.bold,
        decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none);
  }

  static textStyleRegular(
      {double size = 16, Color textColor = primaryColor, bool isDone = false}) {
    return GoogleFonts.poppins(
        fontSize: size,
        color: textColor,
        fontWeight: FontWeight.w400,
        decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none);
  }
}
