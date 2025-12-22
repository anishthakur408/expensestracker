import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFF121212); // Deep dark background
  static const Color surface = Color(0xFF1E1E1E); // Slightly lighter for cards
  static const Color accent = Color(
    0xFFCCFF00,
  ); // Neon Lime for primary actions
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color error = Color(0xFFFF4C4C);
  static const Color success = Color(0xFF00FF9D);
}

class AppTextStyles {
  static TextStyle get displayLarge => GoogleFonts.outfit(
    fontSize: 56,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.1,
  );

  static TextStyle get displayMedium => GoogleFonts.outfit(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get headlineLarge => GoogleFonts.outfit(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get titleLarge => GoogleFonts.outfit(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyLarge =>
      GoogleFonts.dmSans(fontSize: 18, color: AppColors.textSecondary);

  static TextStyle get bodyMedium =>
      GoogleFonts.dmSans(fontSize: 16, color: AppColors.textSecondary);

  static TextStyle get mainBalance => GoogleFonts.outfit(
    fontSize: 64, // BIG FONT for balance
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -2.0,
  );
}
