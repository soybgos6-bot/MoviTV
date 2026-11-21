import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_2see/core/routes/app_routes.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/theme/app_spacing.dart';
import 'package:movies_2see/core/theme/app_typography.dart';
import 'package:movies_2see/core/utils/genre_utils.dart';
import 'package:movies_2see/core/widgets/effects/fade_slide_in.dart';
import 'package:movies_2see/core/widgets/effects/gradient_text.dart';
import 'package:movies_2see/core/widgets/effects/pressable_scale.dart';
import 'package:movies_2see/features/home/presentation/providers/home_provider.dart';
import 'package:movies_2see/features/home/presentation/providers/home_state.dart';
import 'package:movies_2see/features/home/presentation/widget/movie_card.dart';
import 'package:movies_2see/features/home/presentation/widget/section_title_widget.dart';
import 'package:movies_2see/features/home/presentation/widget/trending_movie_card.dart';
import 'package:movies_2see/features/see_all/domain/entity/see_all_item.dart';
import 'package:sizer/sizer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(homeNotifierProvider);

    return info.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        body: _ErrorView(
          message: '$error',
          onRetry: () => ref.invalidate(homeNotifierProvider),
        ),
      ),
      data: (homeState) => Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.surface,
            onRefresh: () => ref.read(homeNotifierProvider.notifier).refresh(),
            child: _HomeContent(homeState: homeState),
          ),
        ),
      ),
    );
  }
}

void _openDetails(BuildContext context, int movieId) {
  context.push(AppRoutes.movieDetailsLocation(movieId));
}

void _openSeeAll(BuildContext context, SeeAllArgs args) {
  context.push(AppRoutes.seeAll, extra: args);
}

void _openSerieDetails(BuildContext context, int serieId) {
  context.push(AppRoutes.serieDetailsLocation(serieId));
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.homeState});

  final HomeState homeState;

  @override
  Widget build(BuildContext context) {
    final trending = homeState.trendingMovie;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: AppSpacing.xl),
      children: [
        FadeSlideIn(
          offset: const Offset(-0.2, 0),
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Row(
              children: [
                Icon(Icons.live_tv_rounded, color: AppColors.primary, size: 9.w),
                SizedBox(width: AppSpacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(
                      'MOVI TV',
                      style: AppTypography.headlineXl.copyWith(fontSize: 34),
                      gradient: const LinearGradient(
                        colors: [AppColors.tertiary, AppColors.primary, AppColors.secondary],
                      ),
                    ),
                    Text(
                      'Películas y series para ti',
                      style: AppTypography.labelMd.copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        Center(
          child: FadeSlideIn(
            delay: const Duration(milliseconds: 150),
            child: PressableScale(
              scale: 0.97,
              child: TrendingMovieCard(
            movie: trending,
            genres: genreNames(trending.genreIds, homeState.movieGenres, max: 3),
            onTap: () => _openDetails(context, trending.id),
              ),
            ),
          ),
        ),
        SizedBox(height: AppSpacing.lg),
        FadeSlideIn(
          delay: const Duration(milliseconds: 250),
          child: SectionTitleWidget(
            title: 'Películas en cartelera',
            onTap: () => _openSeeAll(
              context,
              SeeAllArgs(
                title: 'Películas en cartelera',
                items: homeState.allPlayNowMovies
                    .map((m) => SeeAllItem(
                          id: m.id,
                          title: m.title,
                          posterPath: m.posterPath,
                          date: m.releaseDate,
                          voteAverage: m.voteAverage,
                          genre: genreNames(m.genreIds, homeState.movieGenres),
                          isSerie: false,
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        _HorizontalList(
          itemCount: homeState.playNowMovies.length,
          itemBuilder: (context, index) {
            final movie = homeState.playNowMovies[index];
            return MovieCard(
              posterPath: movie.posterPath,
              title: movie.title,
              releaseDate: movie.releaseDate,
              voteAverage: movie.voteAverage,
              genre: genreNames(movie.genreIds, homeState.movieGenres),
              onTap: () => _openDetails(context, movie.id),
            );
          },
        ),
        SizedBox(height: AppSpacing.lg),
        FadeSlideIn(
          delay: const Duration(milliseconds: 250),
          child: SectionTitleWidget(
            title: 'Top populares',
            onTap: () => _openSeeAll(
              context,
              SeeAllArgs(
                title: 'Top populares',
                showRanking: true,
                items: homeState.allTopRatedMovies
                    .map((m) => SeeAllItem(
                          id: m.id,
                          title: m.title,
                          posterPath: m.posterPath,
                          date: m.releaseDate,
                          voteAverage: m.voteAverage,
                          genre: genreNames(m.genreIds, homeState.movieGenres),
                          isSerie: false,
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        _HorizontalList(
          itemCount: homeState.topRatedMovies.length,
          itemBuilder: (context, index) {
            final movie = homeState.topRatedMovies[index];
            return MovieCard(
              rank: index + 1,
              posterPath: movie.posterPath,
              title: movie.title,
              releaseDate: movie.releaseDate,
              voteAverage: movie.voteAverage,
              genre: genreNames(movie.genreIds, homeState.movieGenres),
              onTap: () => _openDetails(context, movie.id),
            );
          },
        ),
        SizedBox(height: AppSpacing.lg),
        FadeSlideIn(
          delay: const Duration(milliseconds: 250),
          child: SectionTitleWidget(
            title: 'Series en emisión',
            onTap: () => _openSeeAll(
              context,
              SeeAllArgs(
                title: 'Series en emisión',
                items: homeState.allOnAirSeries
                    .map((s) => SeeAllItem(
                          id: s.id,
                          title: s.name,
                          posterPath: s.posterPath,
                          date: s.firstAirDate,
                          voteAverage: s.voteAverage,
                          genre: genreNames(s.genreIds, homeState.tvGenres),
                          isSerie: true,
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        _HorizontalList(
          itemCount: homeState.onAirSeries.length,
          itemBuilder: (context, index) {
            final serie = homeState.onAirSeries[index];
            return MovieCard(
              posterPath: serie.posterPath,
              title: serie.name,
              releaseDate: serie.firstAirDate,
              voteAverage: serie.voteAverage,
              genre: genreNames(serie.genreIds, homeState.tvGenres),
              onTap: () => _openSerieDetails(context, serie.id),
            );
          },
        ),
        SizedBox(height: AppSpacing.lg),
        FadeSlideIn(
          delay: const Duration(milliseconds: 250),
          child: SectionTitleWidget(
            title: 'Series mejor calificadas',
            onTap: () => _openSeeAll(
              context,
              SeeAllArgs(
                title: 'Series mejor calificadas',
                showRanking: true,
                items: homeState.allTopRatedSeries
                    .map((s) => SeeAllItem(
                          id: s.id,
                          title: s.name,
                          posterPath: s.posterPath,
                          date: s.firstAirDate,
                          voteAverage: s.voteAverage,
                          genre: genreNames(s.genreIds, homeState.tvGenres),
                          isSerie: true,
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        _HorizontalList(
          itemCount: homeState.topRatedSeries.length,
          itemBuilder: (context, index) {
            final serie = homeState.topRatedSeries[index];
            return MovieCard(
              rank: index + 1,
              posterPath: serie.posterPath,
              title: serie.name,
              releaseDate: serie.firstAirDate,
              voteAverage: serie.voteAverage,
              genre: genreNames(serie.genreIds, homeState.tvGenres),
              onTap: () => _openSerieDetails(context, serie.id),
            );
          },
        ),
      ],
    );
  }
}

class _HorizontalList extends StatelessWidget {
  const _HorizontalList({required this.itemCount, required this.itemBuilder});

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return Padding(
        padding: AppSpacing.screenPadding,
        child: Text(
          'No hay elementos disponibles.',
          style: AppTypography.bodySm,
        ),
      );
    }
    return SizedBox(
      height: 34.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: AppSpacing.screenPadding,
        itemCount: itemCount,
        separatorBuilder: (context, index) => SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) => FadeSlideIn(
          delay: Duration(milliseconds: 80 * (index < 6 ? index : 6)),
          offset: const Offset(0.35, 0),
          child: PressableScale(child: itemBuilder(context, index)),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              SizedBox(height: AppSpacing.md),
              Text(
                message,
                style: AppTypography.bodyMd,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.lg),
              ElevatedButton(onPressed: onRetry, child: const Text('Reintentar')),
            ],
          ),
        ),
      ),
    );
  }
}
