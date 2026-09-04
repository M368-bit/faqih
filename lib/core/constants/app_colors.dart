import 'package:flutter/material.dart';

/// 2026 Luxury Islamic Color Palette for جامع الشيخ عبد القادر فقيه
class AppColors {
  // Brand Primary & Accent
  static const Color primaryEmerald = Color(0xFF064E3B); // Deep Emerald Green
  static const Color primaryEmeraldLight = Color(0xFF047857);
  static const Color primaryEmeraldDark = Color(0xFF022C22);
  static const Color emeraldSurface = Color(0xFF062E25);

  // Warm Premium Gold & Brass
  static const Color gold = Color(0xFFD97706); // Warm Premium Gold
  static const Color goldLight = Color(0xFFF59E0B);
  static const Color goldDark = Color(0xFFB45309);
  static const Color goldAccent = Color(0xFFFDE68A);

  // Backgrounds & Neutrals (Light Mode)
  static const Color backgroundLight = Color(0xFFF8FAFC); // Soft Off-White
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE2E8F0);

  // Backgrounds & Neutrals (Dark Mode)
  static const Color backgroundDark = Color(0xFF080D11); // Obsidian / Deep Slate
  static const Color surfaceDark = Color(0xFF0E171E);
  static const Color cardDark = Color(0xFF132029);
  static const Color borderDark = Color(0xFF1E2F3D);

  // Slate & Muted Grays
  static const Color slate = Color(0xFF64748B); // Muted Slate Grey
  static const Color slateLight = Color(0xFF94A3B8);
  static const Color slateDark = Color(0xFF334155);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textMutedLight = Color(0xFF94A3B8);

  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);
  static const Color textMutedDark = Color(0xFF64748B);

  // Status & Utility Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Glassmorphism Overlay Gradients
  static const LinearGradient emeraldGlassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xCC064E3B),
      Color(0x99047857),
    ],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF59E0B),
      Color(0xFFD97706),
    ],
  );

  static const LinearGradient cardGlassLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xF0FFFFFF),
      Color(0xD0F8FAFC),
    ],
  );

  static const LinearGradient cardGlassDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xE6132029),
      Color(0xCC0E171E),
    ],
  );
}
