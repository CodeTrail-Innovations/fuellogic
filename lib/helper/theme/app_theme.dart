import 'package:flutter/material.dart';
import 'package:fuellogic/helper/theme/app_text_styles.dart';

class AppTheme {
  static const Color primaryRed = Color(0xFFD32F2F);
  static const Color primaryGrey = Color(0xFF9E9E9E);

  static final ThemeData lightTheme = ThemeData(

    primaryColor: primaryRed,
    scaffoldBackgroundColor: Colors.grey[100],
    colorScheme: ColorScheme.light(
      primary: primaryRed,
      secondary: primaryGrey,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.grey[100],
      foregroundColor: Colors.black87,
      titleTextStyle: AppTextStyles.labelStyle,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryRed),
      ),
      labelStyle: TextStyle(color: primaryGrey),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
