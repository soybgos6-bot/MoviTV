import 'package:movies_2see/features/movie_details/domain/entity/genre_entity.dart';
import 'package:movies_2see/features/serie_details/domain/entity/serie_details_entity.dart';

class SerieDetailsState {
  const SerieDetailsState({
    required this.serieDetails,
    required this.genres,
  });

  final SerieDetailsEntity serieDetails;
  final List<GenreEntity> genres;

  SerieDetailsState copyWith({
    SerieDetailsEntity? serieDetails,
    List<GenreEntity>? genres,
  }) {
    return SerieDetailsState(
      serieDetails: serieDetails ?? this.serieDetails,
      genres: genres ?? this.genres,
    );
  }
}
