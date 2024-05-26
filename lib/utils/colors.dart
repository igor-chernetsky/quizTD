import 'package:flutter/material.dart';

class AppColors {
  static final primaryColor = getMaterialColor(const Color(0xFF2196F3));
  static final secondaryColor = getMaterialColor(const Color(0xFFBBDEFB));
  static final accentColor = getMaterialColor(const Color(0xFF0D47A1));
  static final neutralBackground = getMaterialColor(const Color(0xFFF5F5F5));
  static final textColor = getMaterialColor(const Color(0xFF333333));
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;
  final int alpha = color.alpha;

  final Map<int, Color> shades = {
    50: Color.fromARGB(alpha, red, green, blue),
    100: Color.fromARGB(alpha, red, green, blue),
    200: Color.fromARGB(alpha, red, green, blue),
    300: Color.fromARGB(alpha, red, green, blue),
    400: Color.fromARGB(alpha, red, green, blue),
    500: Color.fromARGB(alpha, red, green, blue),
    600: Color.fromARGB(alpha, red, green, blue),
    700: Color.fromARGB(alpha, red, green, blue),
    800: Color.fromARGB(alpha, red, green, blue),
    900: Color.fromARGB(alpha, red, green, blue),
  };

  return MaterialColor(color.value, shades);
}

Color getHealthColor(double hp) {
  if (hp < 0.33) return const Color.fromRGBO(230, 76, 76, 0.8);
  if (hp < 0.66) return const Color.fromRGBO(230, 150, 46, 0.8);
  return const Color.fromRGBO(76, 230, 117, 0.8);
}
