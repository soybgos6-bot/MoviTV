import 'package:movies_2see/features/top_rated_series/domain/entity/top_rated_serie_entity.dart';

class TopRatedSerieModel {
  const TopRatedSerieModel({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
  });

  final bool adult;
  final String? backdropPath;
  final int id;
  final String name;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final String? posterPath;
  final List<int> genreIds;
  final double popularity;
  final DateTime? firstAirDate;
  final double voteAverage;
  final int voteCount;
  final List<String> originCountry;

  factory TopRatedSerieModel.fromJson(Map<String, dynamic> json) {
    return TopRatedSerieModel(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String?,
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      originalLanguage: json['original_language'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>? ?? const [])
          .map((e) => (e as num).toInt())
          .toList(),
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      firstAirDate: DateTime.tryParse(json['first_air_date'] as String? ?? ''),
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      originCountry: (json['origin_country'] as List<dynamic>? ?? const [])
          .map((e) => e as String)
          .toList(),
    );
  }

  TopRatedSerieEntity toEntity() {
    return TopRatedSerieEntity(
      adult: adult,
      backdropPath: backdropPath,
      id: id,
      name: name,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      genreIds: genreIds,
      popularity: popularity,
      firstAirDate: firstAirDate,
      voteAverage: voteAverage,
      voteCount: voteCount,
      originCountry: originCountry,
    );
  }

  TopRatedSerieModel copyWith({
    bool? adult,
    String? backdropPath,
    int? id,
    String? name,
    String? originalLanguage,
    String? originalName,
    String? overview,
    String? posterPath,
    List<int>? genreIds,
    double? popularity,
    DateTime? firstAirDate,
    double? voteAverage,
    int? voteCount,
    List<String>? originCountry,
  }) {
    return TopRatedSerieModel(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      id: id ?? this.id,
      name: name ?? this.name,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      genreIds: genreIds ?? this.genreIds,
      popularity: popularity ?? this.popularity,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      originCountry: originCountry ?? this.originCountry,
    );
  }

  @override
  String toString() => 'TopRatedSerieModel(id: $id, name: $name, firstAirDate: $firstAirDate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TopRatedSerieModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
