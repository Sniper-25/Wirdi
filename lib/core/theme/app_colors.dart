import 'package:flutter/material.dart';

/// Centralized color palette for Wirdi (وِردي) – Approved "Calm Green" identity.
///
/// Visual principles:
/// - Deep elegant green as primary color.
/// - Soft green as secondary color.
/// - Warm ivory and clean white backgrounds.
/// - Soft, subtle cards with gentle borders.
/// - Very limited, tasteful decorative accents.
class AppColors {
  AppColors._();

  // Deep Elegant Green (Primary)
  static const Color emeraldPrimary = Color(0xFF0D5C3E);
  static const Color emeraldDark = Color(0xFF09442E);
  static const Color emeraldLight = Color(0xFF167953);

  // Soft Sage Green (Secondary)
  static const Color softGreen = Color(0xFF3D8A68);
  static const Color softGreenLight = Color(0xFF5CA384);
  static const Color softGreenContainer = Color(0xFFE6F2EB);
  static const Color softGreenDarkContainer = Color(0xFF19362A);

  // Subtle Muted Gold (Used very sparingly for highlights only)
  static const Color goldMuted = Color(0xFFB59353);
  static const Color goldSoft = Color(0xFFD8C08A);

  // Light Mode (Warm Ivory & Clean White)
  static const Color lightBackground = Color(0xFFFAF8F5);
  static const Color lightSurface = Color(0xFFF3EFE8);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardSubtle = Color(0xFFF7F5F0);
  static const Color lightTextPrimary = Color(0xFF1A2621);
  static const Color lightTextSecondary = Color(0xFF5B6E64);
  static const Color lightTextTertiary = Color(0xFF8B9E95);
  static const Color lightBorder = Color(0xFFE2EAE5);
  static const Color lightDivider = Color(0xFFECEFEA);

  // Dark Mode (Spiritual Deep Forest Slate)
  static const Color darkBackground = Color(0xFF0E1613);
  static const Color darkSurface = Color(0xFF14201C);
  static const Color darkCard = Color(0xFF1A2823);
  static const Color darkCardSubtle = Color(0xFF16231E);
  static const Color darkTextPrimary = Color(0xFFF0F5F2);
  static const Color darkTextSecondary = Color(0xFF9AB0A5);
  static const Color darkTextTertiary = Color(0xFF6A7F75);
  static const Color darkBorder = Color(0xFF23352D);
  static const Color darkDivider = Color(0xFF1E2E27);

  // Semantic Feedback Colors
  static const Color success = Color(0xFF2E7D32);
  static const Color successContainer = Color(0xFFE8F5E9);
  static const Color warning = Color(0xFFD97706);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFC53030);
  static const Color errorContainer = Color(0xFFFDE8E8);

  // Mushaf Reader Paper Colors
  static const Color mushafPaperLight = Color(0xFFFDFBF7);
  static const Color mushafPaperDark = Color(0xFF121B17);
  static const Color mushafBorder = Color(0xFFDED6C4);
}
