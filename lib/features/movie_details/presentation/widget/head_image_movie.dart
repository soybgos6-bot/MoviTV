import 'package:flutter/material.dart';
import 'package:movies_2see/core/constants/app_env.dart';
import 'package:movies_2see/core/constants/genres_icons.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/theme/app_typography.dart';
import 'package:movies_2see/core/widgets/effects/fade_slide_in.dart';
import 'package:movies_2see/core/widgets/movie_poster.dart';
import 'package:movies_2see/features/movie_details/domain/entity/genre_entity.dart';
import 'package:movies_2see/features/movie_details/presentation/widget/genre_card_widget.dart';
import 'package:sizer/sizer.dart';

class HeadImageMovie extends StatelessWidget {
  const HeadImageMovie({
    super.key,
    required this.imagePath,
    required this.genres,
    required this.title,
  });

  final String? imagePath;
  final List<GenreEntity> genres;
  final String title;

  static const int _maxShortTitle = 24;

  @override
  Widget build(BuildContext context) {
    final path = imagePath;
    final imageUrl = path == null ? null : '${AppEnv.imgOriginal}$path';
    final isShortTitle = title.length <= _maxShortTitle;

    return Container(
      width: 90.w,
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.sp),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.sp),
        child: Stack(
          fit: StackFit.expand,
          children: [
            MoviePoster(url: imageUrl),

            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.85),
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.05),
                  ],
                ),
              ),
            ),

            Positioned(
              left: 4.w,
              right: 4.w,
              bottom: 6.h,
              child: Text(
                title,
                style: isShortTitle
                    ? AppTypography.headlineXl
                    : AppTypography.headlineLg,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 1.5.h,
              child: SizedBox(
                height: 3.5.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemCount: genres.length,
                  separatorBuilder: (context, index) => SizedBox(width: 2.w),
                  itemBuilder: (context, index) {
                    final genre = genres[index];
                    return FadeSlideIn(
                      delay: Duration(milliseconds: 300 + 120 * index),
                      offset: const Offset(0.6, 0),
                      child: GenreCardWidget(
                        genreName: genre.name,
                        icon: GenresIcons.fromId(genre.id),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
