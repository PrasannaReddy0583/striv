import 'package:flutter/material.dart';

/// Single source of truth for every colour used across the app.
/// All other colour classes (AppPalette, local AppColors) delegate here.
class AppColors {
  // ─── Core Backgrounds ─────────────────────────────────────────────────────
  static const Color background = Color(0xFFF8F7F6);
  static const Color primaryBackground = Color(0xFFFCF4EB);
  static const Color backgroundTop = Color(0xFFFDF5EC);
  static const Color backgroundBottom = Color(0xFFF5E7DA);

  // ─── Brand Accent ─────────────────────────────────────────────────────────
  static const Color messageColor = Color(0xFFEFBA8F); // primary CTA / bottom-nav active
  static const Color accent = Color(0xFFEAD2BD);       // chips, cards, soft borders
  static const Color gold = Color(0xFFE8B430);
  static const Color highlight = Color(0xFFF5E8DC);    // soft elevation / progress bg

  // ─── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF57493F);
  static const Color textTerenary = Color(0xFF57493F); // backward-compat alias
  static const Color textHeading = Color(0xFF4A3C32);
  static const Color textSubtitle = Color(0xFF8C7F72);
  static const Color textBody = Color(0xFF6D635A);
  static const Color textMuted = Colors.black54;
  static const Color inactive = Colors.black26;

  // ─── Surfaces / Cards ─────────────────────────────────────────────────────
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardAlt = Color(0xFFF8F3ED);
  static const Color softElev = Color(0xFFF5E8DC);

  // ─── Notification Screen ──────────────────────────────────────────────────
  static const Color notifBackground = Color(0xFFF6EEE5);
  static const Color notifCard = Color(0xFFF8F3ED);
  static const Color notifChip = Color(0xFFF6EEE6);
  static const Color notifChipSelected = Color(0xFFEAD2BD);
  static const Color notifText = Color(0xFF8B7F75);

  // ─── Status Indicators ────────────────────────────────────────────────────
  static const Color unseen = Color(0xFFEEAC1B);
  static const Color seen = Color(0xFF07DE0E);
  static const Color red = Color(0xFFF44336);
  static const Color lightgreen = Color(0xFF8BC34A);

  // ─── Utility ──────────────────────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color iconColor = Colors.black54;
}
