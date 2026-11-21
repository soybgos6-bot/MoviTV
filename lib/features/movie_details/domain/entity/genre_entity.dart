class GenreEntity {
  const GenreEntity({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  GenreEntity copyWith({
    int? id,
    String? name,
  }) {
    return GenreEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'GenreEntity(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GenreEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
