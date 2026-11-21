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
import 'package:movies_2see/features/movie_details/presentation/widget/detail_section.dart';
import 'package:movies_2see/features/movie_details/presentation/widget/head_image_movie.dart';
import 'package:movies_2see/features/movie_details/presentation/widget/info_chip.dart';
import 'package:movies_2see/features/serie_details/domain/entity/serie_details_entity.dart';
import 'package:movies_2see/features/serie_details/presentation/providers/serie_details_provider.dart';
import 'package:movies_2see/features/serie_details/presentation/providers/serie_details_state.dart';
import 'package:sizer/sizer.dart';

class SerieDetailsPage extends ConsumerWidget {
  const SerieDetailsPage({super.key, required this.serieId});

  final int? serieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = serieId;
    if (id == null) {
      return const MessageScaffold(message: 'No serie found');
    }

    final detailsSerieAsync = ref.watch(serieDetailsProvider(id));

    return detailsSerieAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => MessageScaffold(
        message: 'No serie found\n$error',
        onRetry: () => ref.invalidate(serieDetailsProvider(id)),
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
          imagePath: data.serieDetails.posterPath,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.paddingOf(context).top + kToolbarHeight,
              bottom: 4.h,
            ),
            child: _SerieDetailsBody(data: data, serieId: id),
          ),
        ),
      ),
    );
  }
}

class _SerieDetailsBody extends ConsumerWidget {
  const _SerieDetailsBody({required this.data, required this.serieId});

  final SerieDetailsState data;
  final int serieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serie = data.serieDetails;
    final cast = ref.watch(serieCastProvider(serieId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        FadeSlideIn(
          offset: const Offset(0, 0.08),
          child: HeadImageMovie(
            imagePath: serie.posterPath,
            genres: data.genres,
            title: serie.name,
          ),
        ),
        SizedBox(height: 2.5.h),
        FadeSlideIn(
          delay: const Duration(milliseconds: 250),
          child: OverviewPopularityWidget(
            overview: serie.overview,
            voteAverage: serie.voteAverage,
            voteCount: serie.voteCount,
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
                  child: FactsCard(facts: _serieFacts(serie)),
                ),
                DetailSection(
                  title: 'Disponible en',
                  collapsible: true,
                  child: InfoChipList(
                    labels: serie.networks.map((n) => n.name).toList(),
                    highlighted: true,
                  ),
                ),
                DetailSection(
                  title: 'Creada por',
                  collapsible: true,
                  child: InfoChipList(labels: serie.createdBy),
                ),
                DetailSection(
                  title: 'Compañías de producción',
                  collapsible: true,
                  child: InfoChipList(
                    labels: serie.productionCompanies.map((c) => c.name).toList(),
                  ),
                ),
                DetailSection(
                  title: 'Idiomas',
                  collapsible: true,
                  child: InfoChipList(
                    labels: serie.spokenLanguages
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

  List<(String, String)> _serieFacts(SerieDetailsEntity serie) {
    final first = serie.firstAirDate;
    final last = serie.lastAirDate;
    final runtime = serie.episodeRunTime.isEmpty
        ? null
        : formatRuntime(serie.episodeRunTime.first);
    return [
      if (first != null) ('Primera emisión', formatDate(first)),
      if (last != null) ('Última emisión', formatDate(last)),
      if (serie.numberOfSeasons > 0)
        ('Temporadas', serie.numberOfSeasons.toString()),
      if (serie.numberOfEpisodes > 0)
        ('Episodios', serie.numberOfEpisodes.toString()),
      if (runtime != null) ('Duración por episodio', runtime),
      if (serie.status.isNotEmpty) ('Estado', translateStatus(serie.status)),
    ];
  }
}
