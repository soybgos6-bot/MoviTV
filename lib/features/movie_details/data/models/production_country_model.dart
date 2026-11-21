import 'package:movies_2see/features/movie_details/domain/entity/production_country_entity.dart';

class ProductionCountryModel {
  const ProductionCountryModel({
    required this.iso31661,
    required this.name,
  });

  final String iso31661;
  final String name;

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) {
    return ProductionCountryModel(
      iso31661: json['iso_3166_1'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  ProductionCountryEntity toEntity() {
    return ProductionCountryEntity(
      iso31661: iso31661,
      name: name,
    );
  }

  ProductionCountryModel copyWith({
    String? iso31661,
    String? name,
  }) {
    return ProductionCountryModel(
      iso31661: iso31661 ?? this.iso31661,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'ProductionCountryModel(iso31661: $iso31661, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductionCountryModel && other.iso31661 == iso31661;
  }

  @override
  int get hashCode => iso31661.hashCode;
}
