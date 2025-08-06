import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Light theme colors
  static const Color primaryColor = Color(0xFF18274B);
  static const Color secondaryColor = Color(0xFF3C4865);
  static const Color accentColor = Color(0xFF9DA4B3);
  static const Color backgroundColor = Color(0xFFF2F6F9);
  static const Color textColor = Color(0xFF333333);
  static const Color errorColor = Color(0xFFE74C3C);

  // Dark theme specific colors
  static const Color darkBackground = Color(0xFF0F1419); // Very dark blue-gray
  static const Color darkSurface = Color(
    0xFF1A1F2E,
  ); // Slightly lighter for cards/surfaces
  static const Color darkPrimary = Color(
    0xFF4A90E2,
  ); // Lighter blue for primary actions
  static const Color darkSecondary = Color(
    0xFF7BA7D9,
  ); // Even lighter blue for secondary
  static const Color darkAccent = Color(
    0xFFB8C5D6,
  ); // Light gray-blue for accents
  static const Color darkText = Color(0xFFE8ECEF); // Off-white for text
  static const Color darkTextSecondary = Color(0xFFB0B8C1); // Muted text
}

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  fontFamily: GoogleFonts.poppins().fontFamily,

  colorScheme: ColorScheme.light(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    surface: Colors.white,
    background: AppColors.backgroundColor,
    error: AppColors.errorColor,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.textColor,
    onBackground: AppColors.textColor,
    onError: Colors.white,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    displayLarge: TextStyle(
      color: AppColors.textColor,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: AppColors.textColor,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: AppColors.textColor,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      color: AppColors.textColor,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: AppColors.textColor,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: AppColors.textColor,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      color: AppColors.textColor,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: AppColors.textColor,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: AppColors.textColor,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(color: AppColors.textColor),
    bodyMedium: TextStyle(color: AppColors.textColor),
    bodySmall: TextStyle(color: AppColors.accentColor),
    labelLarge: TextStyle(
      color: AppColors.textColor,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(color: AppColors.accentColor),
    labelSmall: TextStyle(color: AppColors.accentColor),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: AppColors.darkPrimary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  fontFamily: GoogleFonts.poppins().fontFamily,

  colorScheme: ColorScheme.dark(
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkSecondary,
    surface: AppColors.darkSurface,
    background: AppColors.darkBackground,
    error: AppColors.errorColor,
    onPrimary: AppColors.darkBackground, // Dark text on primary color
    onSecondary: AppColors.darkBackground,
    onSurface: AppColors.darkText,
    onBackground: AppColors.darkText,
    onError: Colors.white,
    // Additional colors for better theming
    tertiary: AppColors.darkAccent,
    onTertiary: AppColors.darkBackground,
    surfaceVariant: Color(0xFF242938), // For elevated surfaces
    onSurfaceVariant: AppColors.darkTextSecondary,
    outline: Color(0xFF3D4654), // For borders and dividers
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.darkText,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: AppColors.darkText,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: AppColors.darkText,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: AppColors.darkText,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: AppColors.darkText,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      color: AppColors.darkText,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: AppColors.darkText,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: AppColors.darkText,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      color: AppColors.darkText,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: AppColors.darkText,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: AppColors.darkText,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(color: AppColors.darkText),
    bodyMedium: TextStyle(color: AppColors.darkText),
    bodySmall: TextStyle(color: AppColors.darkTextSecondary),
    labelLarge: TextStyle(
      color: AppColors.darkText,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(color: AppColors.darkTextSecondary),
    labelSmall: TextStyle(color: AppColors.darkTextSecondary),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: AppColors.darkBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // Additional theming for better dark mode experience
  dividerTheme: DividerThemeData(color: Color(0xFF3D4654)),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF3D4654)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF3D4654)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.darkPrimary),
    ),
    labelStyle: TextStyle(color: AppColors.darkTextSecondary),
    hintStyle: TextStyle(color: AppColors.darkTextSecondary),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedItemColor: AppColors.darkPrimary,
    unselectedItemColor: AppColors.darkTextSecondary,
    type: BottomNavigationBarType.fixed,
  ),
);
