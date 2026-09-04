import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTextStyles {
  // Base font family: Tajawal & Cairo
  static TextStyle get displayLarge => GoogleFonts.cairo(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        height: 1.3,
      );

  static TextStyle get displayMedium => GoogleFonts.cairo(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        height: 1.3,
      );

  static TextStyle get titleLarge => GoogleFonts.cairo(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.3,
      );

  static TextStyle get titleMedium => GoogleFonts.cairo(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );

  static TextStyle get titleSmall => GoogleFonts.cairo(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );

  static TextStyle get bodyLarge => GoogleFonts.tajawal(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.6,
      );

  static TextStyle get bodyMedium => GoogleFonts.tajawal(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.tajawal(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
      );

  static TextStyle get labelLarge => GoogleFonts.tajawal(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get labelSmall => GoogleFonts.tajawal(
        fontSize: 11,
        fontWeight: FontWeight.w500,
      );

  // Quran & Adhkar Arabic Calligraphic Style
  static TextStyle get quranText => GoogleFonts.amiri(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        height: 1.9,
        color: AppColors.primaryEmeraldDark,
      );

  static TextStyle get dhikrText => GoogleFonts.amiri(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.8,
      );
}
