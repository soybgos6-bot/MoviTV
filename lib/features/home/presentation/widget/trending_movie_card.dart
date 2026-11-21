import 'package:flutter/material.dart';
import 'package:movies_2see/core/constants/app_env.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/theme/app_radius.dart';
import 'package:movies_2see/core/theme/app_spacing.dart';
import 'package:movies_2see/core/theme/app_typography.dart';
import 'package:movies_2see/core/widgets/movie_poster.dart';
import 'package:movies_2see/features/trending_movies/domain/entity/trending_movie_entity.dart';
import 'package:sizer/sizer.dart';

class TrendingMovieCard extends StatelessWidget {
  const TrendingMovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.genres,
  });

  final TrendingMovieEntity movie;
  final VoidCallback? onTap;

  final String? genres;

  static const int _longTitleLength = 20;

  @override
  Widget build(BuildContext context) {
    final posterPath = movie.posterPath;
    final posterUrl = posterPath == null ? null : '${AppEnv.imgW500}$posterPath';
    final year = movie.releaseDate?.year.toString();
    final genresText = genres;

    final isLongTitle = movie.title.length >= _longTitleLength;
    final titleStyle = isLongTitle
        ? AppTypography.headlineXl.copyWith(fontSize: 38)
        : AppTypography.headlineXl;

    return Container(
      height: 50.h,
      width: 85.w,
      decoration: BoxDecoration(
        borderRadius: AppRadius.xlAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.30),
            blurRadius: 28,
            spreadRadius: 1,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppRadius.xlAll,
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
              top: AppSpacing.md,
              left: AppSpacing.md,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 0.5.h,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.tertiary, AppColors.secondary],
                  ),
                  borderRadius: AppRadius.pill,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_fire_department,
                        color: AppColors.onPrimary, size: 4.w),
                    SizedBox(width: AppSpacing.xs),
                    Text(
                      'EN TENDENCIA HOY',
                      style: AppTypography.labelMd.copyWith(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.md,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          movie.title,
                          style: titleStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (year != null) ...[
                        SizedBox(width: AppSpacing.sm),
                        Text(year, style: AppTypography.headlineMd),
                      ],
                    ],
                  ),
                  if (genresText != null && genresText.isNotEmpty) ...[
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      genresText.toUpperCase(),
                      style: AppTypography.labelMd.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    movie.overview,
                    style: AppTypography.bodyMd.copyWith(color: Colors.white),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
