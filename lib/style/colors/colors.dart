import 'package:flutter/material.dart';

class AppColors {
  // Color constants
  static const Color primaryColor = Color(0xFF18274B);
  static const Color secondaryColor = Color(0xFF3C4865);
  static const Color accentColor = Color(0xFF9DA4B3);
  static const Color backgroundColor = Color(0xFFF2F6F9);
  static const Color textColor = Color(0xFF333333);
  static const Color errorColor = Color(0xFFE74C3C);
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  colorScheme: ColorScheme.light(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    error: AppColors.errorColor,
  ),
  textTheme: TextTheme(bodyLarge: TextStyle(color: AppColors.textColor)),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.secondaryColor,
  scaffoldBackgroundColor: AppColors.primaryColor,
  colorScheme: ColorScheme.dark(
    primary: AppColors.accentColor,
    secondary: AppColors.secondaryColor,
    error: AppColors.errorColor,
  ),
  textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
);
