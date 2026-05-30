import 'package:flutter/material.dart';
import 'package:striv/core/theme/app_colors.dart';

/// Single source of truth for every text style in the app.
class AppTextStyles {
  // ─── Revalia (brand / decorative titles) ──────────────────────────────────
  static const TextStyle skipText = TextStyle(
    fontFamily: 'Revalia',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );

  static const TextStyle title = TextStyle(
    fontFamily: 'Revalia',
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
    letterSpacing: 1.2,
    height: 1.3,
  );

  // ─── Poppins page & section titles (content / settings screens) ───────────
  static final TextStyle pageTitle = TextStyle(
    fontFamily: 'Poppins',
    color: AppColors.textHeading,
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle sectionTitle = TextStyle(
    fontFamily: 'Poppins',
    color: AppColors.textHeading,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle cardTitle = TextStyle(
    fontFamily: 'Poppins',
    color: AppColors.textHeading,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle cardSubtitle = TextStyle(
    fontFamily: 'Poppins',
    color: AppColors.textSubtitle,
    fontSize: 12,
  );

  static final TextStyle bodyText = TextStyle(
    fontFamily: 'Poppins',
    color: AppColors.textBody,
    fontSize: 14,
  );

  static final TextStyle subtitle = TextStyle(
    fontFamily: 'Poppins',
    color: AppColors.textMuted,
    fontSize: 12,
    height: 1.6,
  );
}
