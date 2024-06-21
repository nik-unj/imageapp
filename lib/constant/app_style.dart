import 'package:flutter/material.dart';

class AppStyle {
  static EdgeInsets verysmallEdgeInsets = const EdgeInsets.all(5);
  static EdgeInsets smallEdgeInsets = const EdgeInsets.all(10);
  static EdgeInsets mediumEdgeInsets = const EdgeInsets.all(20);
  static EdgeInsets largeEdgeInsets = const EdgeInsets.all(50);
  static EdgeInsets vertical10EdgeInsets =
      const EdgeInsets.symmetric(vertical: 10);

  //color
  static const Color primary = Color.fromARGB(255, 76, 224, 244);
  static const Color error = Color(0xffba1a1a);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color success = Colors.green;
  static const Color grey = Colors.grey;

  //sizes
  static double vsmallFontSize = 10;
  static double smallFontSize = 12;
  static double mediumFontSize = 14;
  static double largeFontSize = 16;
  static double xlargeFontSize = 20;

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  //TextStyle
  static TextStyle headingBlack({double size = 25}) {
    return TextStyle(
      color: black,
      fontSize: size,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle primaryHeading({double size = 15}) {
    return TextStyle(
      color: primary,
      fontSize: size,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle normalText({Color textColor = AppStyle.white}) {
    return TextStyle(
      color: textColor,
      fontSize: 15,
    );
  }

  static TextStyle whiteHeading({double fontSize = 15}) {
    return TextStyle(
      color: white,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle textFieldStyle({Color textColor = AppStyle.white}) {
    return TextStyle(
      color: textColor,
      fontSize: 15,
    );
  }

  static TextStyle errorText() {
    return const TextStyle(
      color: error,
      fontSize: 13,
    );
  }

  static InputDecoration textFieldPrimary({required String hintText}) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: primary,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: primary,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: error,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: error,
          width: 1,
        ),
      ),
      errorStyle: textFieldStyle().copyWith(color: error),
      contentPadding: const EdgeInsets.only(top: 10, left: 10),
      fillColor: primary.withOpacity(0.2),
      filled: true,
      hintText: hintText,
      hintStyle: textFieldStyle(textColor: primary),
    );
  }
}
