import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundTop = Color(0xFFFDF5EC);
  static const Color backgroundBottom = Color(0xFFF5E7DA);
  static const Color heading = Color(0xFF4A3C32);
  static const Color subtitle = Color(0xFF8C7F72);
  static const Color card = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFFEAD2BD);
  static const Color gold = Color(0xFFE8B430);
  static const Color textBody = Color(0xFF6D635A);
}

class AppTextStyles {
  static final TextStyle pageTitle = TextStyle(
    fontFamily: "Revalia",
    color: AppColors.heading,
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle sectionTitle = TextStyle(
    fontFamily: "Revalia",
    color: AppColors.heading,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle cardTitle = TextStyle(
    fontFamily: "Poppins",
    color: AppColors.heading,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle cardSubtitle = TextStyle(
    fontFamily: "Poppins",
    color: AppColors.subtitle,
    fontSize: 12,
  );

  static final TextStyle bodyText = TextStyle(
    fontFamily: "Poppins",
    color: AppColors.textBody,
    fontSize: 14,
  );
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundTop,
    colorScheme: const ColorScheme.light(
      primary: AppColors.heading,
      secondary: AppColors.accent,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.pageTitle,
      titleLarge: AppTextStyles.sectionTitle,
      bodyMedium: AppTextStyles.bodyText,
    ),
  );
}
