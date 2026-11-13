import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Configurable typography for Wirdi (وِردي).
///
/// Tailored for high Arabic readability, balanced line-heights,
/// and clear hierarchical structures for Quranic and companion content.
class AppTypography {
  AppTypography._();

  // Configurable primary font families (can be configured to custom bundled font later)
  static const String? primaryFontFamily = null;
  static const List<String> fallbackFontFamilies = [
    'Segoe UI',
    'SF Pro Arabic',
    'Noto Sans Arabic',
    'Cairo',
    'Amiri',
    'Tahoma',
    'sans-serif',
  ];

  static TextTheme createTextTheme(Color textPrimary, Color textSecondary) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: fallbackFontFamilies,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textPrimary,
        height: 1.4,
      ),
      displayMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: fallbackFontFamilies,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimary,
        height: 1.4,
      ),
      headlineLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: fallbackFontFamilies,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        height: 1.4,
      ),
      headlineMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: fallbackFontFamilies,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.4,
      ),
      titleLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: fallbackFontFamilies,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.35,
      ),
      titleMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: fallbackFontFamilies,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.35,
      ),
      bodyLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: fallbackFontFamilies,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textPrimary,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: fallbackFontFamilies,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textSecondary,
        height: 1.6,
      ),
      labelLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: fallbackFontFamilies,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.3,
      ),
      labelMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontFamilyFallback: fallbackFontFamilies,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondary,
        height: 1.3,
      ),
    );
  }

  static TextTheme get lightTextTheme =>
      createTextTheme(AppColors.lightTextPrimary, AppColors.lightTextSecondary);

  static TextTheme get darkTextTheme =>
      createTextTheme(AppColors.darkTextPrimary, AppColors.darkTextSecondary);
}
