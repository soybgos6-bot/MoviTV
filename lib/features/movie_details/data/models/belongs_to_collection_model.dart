import 'package:movies_2see/features/movie_details/domain/entity/belongs_to_collection_entity.dart';

class BelongsToCollectionModel {
  const BelongsToCollectionModel({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;

  factory BelongsToCollectionModel.fromJson(Map<String, dynamic> json) {
    return BelongsToCollectionModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
    );
  }

  BelongsToCollectionEntity toEntity() {
    return BelongsToCollectionEntity(
      id: id,
      name: name,
      posterPath: posterPath,
      backdropPath: backdropPath,
    );
  }

  BelongsToCollectionModel copyWith({
    int? id,
    String? name,
    String? posterPath,
    String? backdropPath,
  }) {
    return BelongsToCollectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
    );
  }

  @override
  String toString() => 'BelongsToCollectionModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BelongsToCollectionModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
