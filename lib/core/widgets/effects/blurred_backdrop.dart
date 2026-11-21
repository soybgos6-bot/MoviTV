import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies_2see/core/constants/app_env.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/widgets/movie_poster.dart';
import 'package:sizer/sizer.dart';

class BlurredBackdrop extends StatelessWidget {
  const BlurredBackdrop({
    super.key,
    required this.imagePath,
    required this.child,
  });

  final String? imagePath;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final path = imagePath;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (path != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 70.h,
            child: ClipRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: MoviePoster(url: '${AppEnv.imgW500}$path'),
              ),
            ),
          ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 70.h,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.background.withValues(alpha: 0.35),
                  AppColors.background.withValues(alpha: 0.75),
                  AppColors.background,
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
