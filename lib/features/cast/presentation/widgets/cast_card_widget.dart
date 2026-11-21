import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:movies_2see/core/constants/app_env.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/theme/app_typography.dart';
import 'package:movies_2see/features/cast/domain/entity/cast_entity.dart';
import 'package:sizer/sizer.dart';

class CastCardWidget extends StatelessWidget {
  const CastCardWidget({super.key, required this.actor});

  final CastEntity actor;

  static double avatarSize() => math.min(22.w, 12.h);

  static double cardHeight() => avatarSize() + 9.h;

  @override
  Widget build(BuildContext context) {
    final photo = actor.profilePath;
    final size = avatarSize();

    return SizedBox(
      width: size + 4.w,
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: ClipOval(
              child: photo == null
                  ? _placeholder(size)
                  : Image.network(
                      '${AppEnv.imgW500}$photo',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _placeholder(size),
                    ),
            ),
          ),
          SizedBox(height: 0.8.h),
          Text(
            actor.name,
            style: AppTypography.labelMd.copyWith(color: AppColors.textPrimary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            actor.character,
            style: AppTypography.labelSm.copyWith(color: AppColors.textMuted),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _placeholder(double size) {
    return ColoredBox(
      color: AppColors.surfaceVariant,
      child: Icon(Icons.person, color: AppColors.textMuted, size: size * 0.5),
    );
  }
}
