import 'package:movies_2see/features/cast/domain/entity/cast_entity.dart';

class CastModel {
  const CastModel({
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

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      character: json['character'] as String? ?? '',
      profilePath: json['profile_path'] as String?,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      order: (json['order'] as num?)?.toInt() ?? 999,
    );
  }

  CastEntity toEntity() {
    return CastEntity(
      id: id,
      name: name,
      character: character,
      profilePath: profilePath,
      knownForDepartment: knownForDepartment,
      order: order,
    );
  }
}
