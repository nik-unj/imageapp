import 'package:flutter/material.dart';

class AppStyle {
  //Color
  static const Color primary = Color.fromARGB(255, 76, 224, 244);
  static const Color error = Color(0xffba1a1a);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color success = Colors.green;
  static const Color grey = Colors.grey;

  //Font Family
  static const String bebasFont = 'Bebas';
  static const String oswladFont = 'Oswald';
  static const String concertFont = 'Concert';

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
      fontWeight: FontWeight.bold,
      fontFamily: bebasFont,
      letterSpacing: 1.5,
    );
  }

  static TextStyle normalText({Color textColor = AppStyle.black}) {
    return TextStyle(
      color: textColor,
      fontSize: 15,
      fontFamily: concertFont,
    );
  }

  static TextStyle textFieldStyle() {
    return const TextStyle(
      color: black,
      fontSize: 15,
      fontFamily: oswladFont,
    );
  }

  static TextStyle textFieldHintStyle() {
    return const TextStyle(
      color: grey,
      fontSize: 15,
      fontFamily: oswladFont,
    );
  }

  static TextStyle textFieldErrorStyle() {
    return const TextStyle(
      color: error,
      fontSize: 10,
      fontFamily: oswladFont,
    );
  }

  static TextStyle errorText() {
    return const TextStyle(
      color: error,
      fontSize: 13,
      fontFamily: oswladFont,
      fontWeight: FontWeight.w700,
    );
  }
}
