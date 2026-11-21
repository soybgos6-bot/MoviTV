import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_2see/core/theme/app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get displayHero => GoogleFonts.bebasNeue(
        fontSize: 72,
        letterSpacing: 3.6,
        height: 1.0,
        color: AppColors.textPrimary,
      );

  static TextStyle get displayHeroMobile => GoogleFonts.bebasNeue(
        fontSize: 52,
        letterSpacing: 2.08,
        height: 1.0,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineXl => GoogleFonts.bebasNeue(
        fontSize: 44,
        letterSpacing: 1.76,
        height: 1.05,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineLg => GoogleFonts.bebasNeue(
        fontSize: 32,
        letterSpacing: 0.96,
        height: 1.1,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineMd => GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineSm => GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyLg => GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMd => GoogleFonts.outfit(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySm => GoogleFonts.outfit(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get labelLg => GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get labelMd => GoogleFonts.outfit(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      );

  static TextStyle get labelSm => GoogleFonts.outfit(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
      );

  static TextTheme get textTheme => TextTheme(
        displayLarge: displayHero,
        displayMedium: displayHeroMobile,
        displaySmall: headlineXl,
        headlineLarge: headlineLg,
        headlineMedium: headlineMd,
        headlineSmall: headlineSm,
        titleLarge: headlineMd,
        titleMedium: headlineSm,
        titleSmall: labelLg,
        bodyLarge: bodyLg,
        bodyMedium: bodyMd,
        bodySmall: bodySm,
        labelLarge: labelLg,
        labelMedium: labelMd,
        labelSmall: labelSm,
      );
}
