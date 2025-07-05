import 'package:flutter/material.dart';

@immutable
class AppColors {
  const AppColors._();

  static const Color primaryColor = Colors.red;
  static const Color textFieldTextColor =
      Color.from(alpha: 1, red: 0, green: 0, blue: 0);
  static const Color textFieldColor = Color.fromRGBO(240, 240, 240, 1);
  static const Color themeColor = Color.fromARGB(255, 62, 96, 183);
  static const Color drawerColor = Colors.white;
  static const Color white = Colors.white;
  static const Color blue = Colors.blue;
  static Color blueLight = Colors.blue.shade200;
  static const Color gradientFirst = Color.fromRGBO(20, 84, 196, 0.6);
  static const Color gradientSecond = Color.fromRGBO(216, 163, 5, 0.6);
  static const Color gradientThird = Color.fromRGBO(227, 137, 2, 0.6);
  static const Color possitiveResult = Colors.green;
  static const Color negativeResult = Colors.red;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color greyLight = Color.fromARGB(255, 240, 240, 240);
  static Color greyUltraLight = Colors.grey.shade100;
  //Color(0xFFE8F0FE);
}
