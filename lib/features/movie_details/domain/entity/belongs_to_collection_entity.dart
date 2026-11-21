class BelongsToCollectionEntity {
  const BelongsToCollectionEntity({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;

  BelongsToCollectionEntity copyWith({
    int? id,
    String? name,
    String? posterPath,
    String? backdropPath,
  }) {
    return BelongsToCollectionEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
    );
  }

  @override
  String toString() => 'BelongsToCollectionEntity(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BelongsToCollectionEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
