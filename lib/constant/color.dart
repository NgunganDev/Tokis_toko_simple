import 'package:flutter/material.dart';

class ColorUse {
  static const Color primC = Color.fromARGB(255, 241, 249, 251);
  static const Color secC = Color.fromARGB(255, 3, 117, 239);
  static const Color hintC = Color.fromARGB(255, 0, 100, 208);
  static const Color getC = Color(0xFFFFFFFF);
  static const Color primD = Color.fromARGB(255, 238, 255, 240);
  static const Color secD = Color(0xFF709775);

  static ThemeData colorSelect(int state) {
    switch (0) {
      case 0:
        return blueScheme;
      case 1:
        return greenScheme;
      case 2:
        return darkScheme;
      default:
        return blueScheme;
    }
  }

  static var blueScheme = ThemeData(
      primaryColor: secC, secondaryHeaderColor: primC, hintColor: getC);

  static var greenScheme = ThemeData(
      primaryColor: secD, secondaryHeaderColor: primD, hintColor: getC);

  static var darkScheme = ThemeData.dark().copyWith(
    primaryColor: secC,
    secondaryHeaderColor: primC,
    hintColor: hintC,
  );
}
