class TrendingSerieEntity {
  const TrendingSerieEntity({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
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
  final String mediaType;
  final List<int> genreIds;
  final double popularity;
  final DateTime? firstAirDate;
  final double voteAverage;
  final int voteCount;
  final List<String> originCountry;

  TrendingSerieEntity copyWith({
    bool? adult,
    String? backdropPath,
    int? id,
    String? name,
    String? originalLanguage,
    String? originalName,
    String? overview,
    String? posterPath,
    String? mediaType,
    List<int>? genreIds,
    double? popularity,
    DateTime? firstAirDate,
    double? voteAverage,
    int? voteCount,
    List<String>? originCountry,
  }) {
    return TrendingSerieEntity(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      id: id ?? this.id,
      name: name ?? this.name,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      mediaType: mediaType ?? this.mediaType,
      genreIds: genreIds ?? this.genreIds,
      popularity: popularity ?? this.popularity,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      originCountry: originCountry ?? this.originCountry,
    );
  }

  @override
  String toString() => 'TrendingSerieEntity(id: $id, name: $name, firstAirDate: $firstAirDate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TrendingSerieEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
