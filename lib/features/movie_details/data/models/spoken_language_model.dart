import 'package:movies_2see/features/movie_details/domain/entity/spoken_language_entity.dart';

class SpokenLanguageModel {
  const SpokenLanguageModel({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  final String englishName;
  final String iso6391;
  final String name;

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) {
    return SpokenLanguageModel(
      englishName: json['english_name'] as String? ?? '',
      iso6391: json['iso_639_1'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  SpokenLanguageEntity toEntity() {
    return SpokenLanguageEntity(
      englishName: englishName,
      iso6391: iso6391,
      name: name,
    );
  }

  SpokenLanguageModel copyWith({
    String? englishName,
    String? iso6391,
    String? name,
  }) {
    return SpokenLanguageModel(
      englishName: englishName ?? this.englishName,
      iso6391: iso6391 ?? this.iso6391,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'SpokenLanguageModel(iso6391: $iso6391, englishName: $englishName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SpokenLanguageModel && other.iso6391 == iso6391;
  }

  @override
  int get hashCode => iso6391.hashCode;
}
