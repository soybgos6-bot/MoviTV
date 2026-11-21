class SpokenLanguageEntity {
  const SpokenLanguageEntity({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguageEntity copyWith({
    String? englishName,
    String? iso6391,
    String? name,
  }) {
    return SpokenLanguageEntity(
      englishName: englishName ?? this.englishName,
      iso6391: iso6391 ?? this.iso6391,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'SpokenLanguageEntity(iso6391: $iso6391, englishName: $englishName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SpokenLanguageEntity && other.iso6391 == iso6391;
  }

  @override
  int get hashCode => iso6391.hashCode;
}
