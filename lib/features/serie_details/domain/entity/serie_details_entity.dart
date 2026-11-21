import 'package:movies_2see/features/movie_details/domain/entity/genre_entity.dart';
import 'package:movies_2see/features/movie_details/domain/entity/production_company_entity.dart';
import 'package:movies_2see/features/movie_details/domain/entity/production_country_entity.dart';
import 'package:movies_2see/features/movie_details/domain/entity/spoken_language_entity.dart';

class SerieDetailsEntity {
  const SerieDetailsEntity({
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.episodeRunTime,
    required this.genres,
    required this.voteAverage,
    required this.voteCount,
    required this.status,
    required this.tagline,
    required this.createdBy,
    required this.networks,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
  });

  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final DateTime? firstAirDate;
  final DateTime? lastAirDate;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final List<int> episodeRunTime;
  final List<GenreEntity> genres;
  final double voteAverage;
  final int voteCount;
  final String status;
  final String? tagline;

  final List<String> createdBy;

  final List<ProductionCompanyEntity> networks;
  final List<ProductionCompanyEntity> productionCompanies;
  final List<ProductionCountryEntity> productionCountries;
  final List<SpokenLanguageEntity> spokenLanguages;
}
