import 'package:flutter/material.dart';
import 'package:movies_2see/core/theme/app_colors.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.ratingColor,
    required this.successColor,
    required this.cardBackground,
    required this.chipBackground,
    required this.posterOverlayGradient,
  });

  final Color ratingColor;
  final Color successColor;
  final Color cardBackground;
  final Color chipBackground;
  final LinearGradient posterOverlayGradient;

  static const AppThemeExtension dark = AppThemeExtension(
    ratingColor: AppColors.tertiary,
    successColor: AppColors.success,
    cardBackground: AppColors.surfaceVariant,
    chipBackground: AppColors.surface,
    posterOverlayGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[AppColors.transparent, AppColors.background],
    ),
  );

  @override
  AppThemeExtension copyWith({
    Color? ratingColor,
    Color? successColor,
    Color? cardBackground,
    Color? chipBackground,
    LinearGradient? posterOverlayGradient,
  }) {
    return AppThemeExtension(
      ratingColor: ratingColor ?? this.ratingColor,
      successColor: successColor ?? this.successColor,
      cardBackground: cardBackground ?? this.cardBackground,
      chipBackground: chipBackground ?? this.chipBackground,
      posterOverlayGradient:
          posterOverlayGradient ?? this.posterOverlayGradient,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      ratingColor: Color.lerp(ratingColor, other.ratingColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      chipBackground: Color.lerp(chipBackground, other.chipBackground, t)!,
      posterOverlayGradient: LinearGradient.lerp(
        posterOverlayGradient,
        other.posterOverlayGradient,
        t,
      )!,
    );
  }
}

extension AppThemeContext on BuildContext {
  AppThemeExtension get appTheme =>
      Theme.of(this).extension<AppThemeExtension>()!;
}
