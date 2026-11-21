import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/utils/format_utils.dart';
import 'package:movies_2see/core/widgets/effects/blurred_backdrop.dart';
import 'package:movies_2see/core/widgets/effects/circle_back_button.dart';
import 'package:movies_2see/core/widgets/effects/fade_slide_in.dart';
import 'package:movies_2see/core/widgets/facts_card.dart';
import 'package:movies_2see/core/widgets/message_scaffold.dart';
import 'package:movies_2see/core/widgets/overview_popularity_widget.dart';
import 'package:movies_2see/features/cast/presentation/providers/cast_provider.dart';
import 'package:movies_2see/features/cast/presentation/widgets/cast_list_widget.dart';
import 'package:movies_2see/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies_2see/features/movie_details/presentation/providers/movie_details_provider.dart';
import 'package:movies_2see/features/movie_details/presentation/providers/movie_details_state.dart';
import 'package:movies_2see/features/movie_details/presentation/widget/detail_section.dart';
import 'package:movies_2see/features/movie_details/presentation/widget/head_image_movie.dart';
import 'package:movies_2see/features/movie_details/presentation/widget/info_chip.dart';
import 'package:sizer/sizer.dart';

class MovieDetailsPage extends ConsumerWidget {
  const MovieDetailsPage({super.key, required this.movieId});

  final int? movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = movieId;
    if (id == null) {
      return const MessageScaffold(message: 'No movie found');
    }

    final detailsMovieAsync = ref.watch(movieDetailsProvider(id));

    return detailsMovieAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => MessageScaffold(
        message: 'No movie found\n$error',
        onRetry: () => ref.invalidate(movieDetailsProvider(id)),
      ),
      data: (data) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          leading: const CircleBackButton(),
        ),
        body: BlurredBackdrop(
          imagePath: data.movieDetails.posterPath,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.paddingOf(context).top + kToolbarHeight,
              bottom: 4.h,
            ),
            child: _MovieDetailsBody(data: data, movieId: id),
          ),
        ),
      ),
    );
  }
}

class _MovieDetailsBody extends ConsumerWidget {
  const _MovieDetailsBody({required this.data, required this.movieId});

  final MovieDetailsState data;
  final int movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = data.movieDetails;
    final cast = ref.watch(movieCastProvider(movieId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),

        FadeSlideIn(
          offset: const Offset(0, 0.08),
          child: HeadImageMovie(
            imagePath: movie.posterPath,
            genres: data.genres,
            title: movie.title,
          ),
        ),
        SizedBox(height: 2.5.h),

        FadeSlideIn(
          delay: const Duration(milliseconds: 250),
          child: OverviewPopularityWidget(
            overview: movie.overview,
            voteAverage: movie.voteAverage,
            voteCount: movie.voteCount,
          ),
        ),

        FadeSlideIn(
          delay: const Duration(milliseconds: 400),
          child: Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: DetailSection(
              title: 'Reparto',
              child: CastListWidget(cast: cast),
            ),
          ),
        ),

        FadeSlideIn(
          delay: const Duration(milliseconds: 550),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailSection(
                  title: 'Datos',
                  collapsible: true,
                  child: FactsCard(facts: _movieFacts(movie)),
                ),
                DetailSection(
                  title: 'Compañías de producción',
                  collapsible: true,
                  child: InfoChipList(
                    labels: movie.productionCompanies.map((c) => c.name).toList(),
                  ),
                ),
                DetailSection(
                  title: 'Países de producción',
                  collapsible: true,
                  child: InfoChipList(
                    labels:
                        movie.productionCountries.map((c) => c.name).toList(),
                  ),
                ),
                DetailSection(
                  title: 'Idiomas',
                  collapsible: true,
                  child: InfoChipList(
                    labels: movie.spokenLanguages
                        .map((l) => l.name.isNotEmpty ? l.name : l.englishName)
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<(String, String)> _movieFacts(MovieDetailsEntity movie) {
    final releaseDate = movie.releaseDate;
    final runtime = formatRuntime(movie.runtime);
    return [
      if (releaseDate != null) ('Estreno', formatDate(releaseDate)),
      if (runtime != null) ('Duración', runtime),
      if (movie.status.isNotEmpty) ('Estado', translateStatus(movie.status)),
      if (movie.budget > 0) ('Presupuesto', formatMoney(movie.budget)),
      if (movie.revenue > 0) ('Recaudación', formatMoney(movie.revenue)),
    ];
  }
}
