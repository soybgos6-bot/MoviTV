import 'package:flutter/material.dart';
import 'package:movies_2see/core/constants/app_env.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/theme/app_radius.dart';
import 'package:movies_2see/core/theme/app_spacing.dart';
import 'package:movies_2see/core/theme/app_theme_extension.dart';
import 'package:movies_2see/core/theme/app_typography.dart';
import 'package:movies_2see/core/widgets/movie_poster.dart';
import 'package:sizer/sizer.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.onTap,
    this.genre,
    this.rank,
  });

  final String? posterPath;
  final String title;
  final DateTime? releaseDate;
  final double voteAverage;
  final VoidCallback onTap;

  final String? genre;

  final int? rank;

  @override
  Widget build(BuildContext context) {
    final path = posterPath;
    final posterUrl = path == null ? null : '${AppEnv.imgW500}$path';
    final year = releaseDate?.year.toString();
    final genreText = genre;
    final position = rank;

    return SizedBox(
      width: 40.w,
      child: ClipRRect(
        borderRadius: AppRadius.lgAll,
        child: Stack(
          fit: StackFit.expand,
          children: [
            MoviePoster(url: posterUrl),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black87,
                  ],
                ),
              ),
            ),
            Positioned(
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              bottom: AppSpacing.sm,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.labelLg,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (genreText != null && genreText.isNotEmpty) ...[
                    SizedBox(height: AppSpacing.xs / 2),
                    Text(
                      genreText,
                      style: AppTypography.labelSm,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      if (year != null)
                        Text(year, style: AppTypography.labelMd),
                      const Spacer(),
                      if (voteAverage > 0) ...[
                        Icon(
                          Icons.star_rounded,
                          size: 4.w,
                          color: context.appTheme.ratingColor,
                        ),
                        SizedBox(width: AppSpacing.xs),
                        Text(
                          voteAverage.toStringAsFixed(1),
                          style: AppTypography.labelMd,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (position != null)
              Positioned(
                top: AppSpacing.sm,
                left: AppSpacing.sm,
                child: _RankBadge(position: position),
              ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(onTap: onTap),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.position});

  final int position;

  @override
  Widget build(BuildContext context) {
    final isTop3 = position <= 3;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.4.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isTop3
              ? const [AppColors.tertiary, AppColors.secondary]
              : [Colors.black87, Colors.black54],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Text(
        '#$position',
        style: AppTypography.labelLg.copyWith(
          color: isTop3 ? AppColors.onPrimary : AppColors.primary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
