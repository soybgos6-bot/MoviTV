import 'package:movies_2see/features/movie_details/domain/entity/genre_entity.dart';

class GenreModel {
  const GenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
    );
  }

  GenreEntity toEntity() {
    return GenreEntity(
      id: id,
      name: name,
    );
  }

  GenreModel copyWith({
    int? id,
    String? name,
  }) {
    return GenreModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'GenreModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GenreModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
