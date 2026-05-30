// Backward-compatibility shim — all values delegate to AppColors.
// New code should import lib/core/theme/app_colors.dart directly.
export 'package:striv/core/theme/app_colors.dart';

import 'package:striv/core/theme/app_colors.dart';

class AppPalette {
  static const background = AppColors.background;
  static const primaryBackground = AppColors.primaryBackground;
  static const messageColor = AppColors.messageColor;
  static const textPrimary = AppColors.textPrimary;
  static const textSecondary = AppColors.textSecondary;
  static const textTerenary = AppColors.textTertiary;
  static const highlight = AppColors.highlight;
  static const iconColor = AppColors.iconColor;
  static const unseen = AppColors.unseen;
  static const seen = AppColors.seen;
  static const white = AppColors.white;
  static const black = AppColors.black;
  static const red = AppColors.red;
  static const lightgreen = AppColors.lightgreen;
  static const transparent = AppColors.transparent;
}
