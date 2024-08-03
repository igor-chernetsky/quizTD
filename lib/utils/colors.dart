import 'package:flutter/material.dart';

class AppColors {
  static final primarySwatch = getMaterialColor(const Color(0xFFD90429));
  static final cardColor = getMaterialColor(const Color(0xFF2E2E2E));
  static final accentColor = getMaterialColor(const Color(0xFFA2031E));
  static final backgroundColor = getMaterialColor(const Color(0xFF121212));
  static final textColor = getMaterialColor(const Color(0xFFFFFFFF));
  static final textSecondary = getMaterialColor(const Color(0xFFB0B0B0));
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
