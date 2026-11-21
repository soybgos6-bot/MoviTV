class CastEntity {
  const CastEntity({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
    required this.knownForDepartment,
    required this.order,
  });

  final int id;
  final String name;

  final String character;

  final String? profilePath;

  final String knownForDepartment;

  final int order;
}
