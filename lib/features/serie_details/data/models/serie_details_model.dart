import 'package:movies_2see/features/movie_details/data/models/genre_model.dart';
import 'package:movies_2see/features/movie_details/data/models/production_company_model.dart';
import 'package:movies_2see/features/movie_details/data/models/production_country_model.dart';
import 'package:movies_2see/features/movie_details/data/models/spoken_language_model.dart';
import 'package:movies_2see/features/serie_details/domain/entity/serie_details_entity.dart';

class SerieDetailsModel {
  const SerieDetailsModel({
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
  final List<GenreModel> genres;
  final double voteAverage;
  final int voteCount;
  final String status;
  final String? tagline;
  final List<String> createdBy;
  final List<ProductionCompanyModel> networks;
  final List<ProductionCompanyModel> productionCompanies;
  final List<ProductionCountryModel> productionCountries;
  final List<SpokenLanguageModel> spokenLanguages;

  static List<Map<String, dynamic>> _list(dynamic value) =>
      (value as List<dynamic>? ?? const [])
          .map((e) => e as Map<String, dynamic>)
          .toList();

  factory SerieDetailsModel.fromJson(Map<String, dynamic> json) {
    return SerieDetailsModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      firstAirDate: DateTime.tryParse(json['first_air_date'] as String? ?? ''),
      lastAirDate: DateTime.tryParse(json['last_air_date'] as String? ?? ''),
      numberOfSeasons: (json['number_of_seasons'] as num?)?.toInt() ?? 0,
      numberOfEpisodes: (json['number_of_episodes'] as num?)?.toInt() ?? 0,
      episodeRunTime: (json['episode_run_time'] as List<dynamic>? ?? const [])
          .map((e) => (e as num).toInt())
          .toList(),
      genres: _list(json['genres']).map(GenreModel.fromJson).toList(),
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? '',
      tagline: json['tagline'] as String?,
      createdBy: _list(json['created_by'])
          .map((e) => e['name'] as String? ?? '')
          .where((name) => name.isNotEmpty)
          .toList(),
      networks:
          _list(json['networks']).map(ProductionCompanyModel.fromJson).toList(),
      productionCompanies: _list(json['production_companies'])
          .map(ProductionCompanyModel.fromJson)
          .toList(),
      productionCountries: _list(json['production_countries'])
          .map(ProductionCountryModel.fromJson)
          .toList(),
      spokenLanguages: _list(json['spoken_languages'])
          .map(SpokenLanguageModel.fromJson)
          .toList(),
    );
  }

  SerieDetailsEntity toEntity() {
    return SerieDetailsEntity(
      id: id,
      name: name,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      lastAirDate: lastAirDate,
      numberOfSeasons: numberOfSeasons,
      numberOfEpisodes: numberOfEpisodes,
      episodeRunTime: episodeRunTime,
      genres: genres.map((e) => e.toEntity()).toList(),
      voteAverage: voteAverage,
      voteCount: voteCount,
      status: status,
      tagline: tagline,
      createdBy: createdBy,
      networks: networks.map((e) => e.toEntity()).toList(),
      productionCompanies:
          productionCompanies.map((e) => e.toEntity()).toList(),
      productionCountries:
          productionCountries.map((e) => e.toEntity()).toList(),
      spokenLanguages: spokenLanguages.map((e) => e.toEntity()).toList(),
    );
  }
}
