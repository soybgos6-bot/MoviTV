import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/theme/app_typography.dart';
import 'package:sizer/sizer.dart';

class AnimatedRating extends StatelessWidget {
  const AnimatedRating({super.key, required this.voteAverage});

  final double voteAverage;

  Color get _color {
    if (voteAverage >= 7) return AppColors.success;
    if (voteAverage >= 5) return AppColors.primary;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final size = math.min(16.w, 10.h);
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: voteAverage.clamp(0, 10).toDouble()),
      duration: const Duration(milliseconds: 1300),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: value / 10,
                  strokeWidth: 5,
                  strokeCap: StrokeCap.round,
                  color: _color,
                  backgroundColor: AppColors.outline,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star_rounded, color: _color, size: 12.sp),
                  Text(
                    value.toStringAsFixed(1),
                    style: AppTypography.labelLg.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
