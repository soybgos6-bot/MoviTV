import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/data/data_source/endpoints.dart';
import 'package:movies_2see/core/dio_options/dio_connector.dart';
import 'package:movies_2see/core/errors/api_exception.dart';
import 'package:movies_2see/features/trending_series/data/models/trending_serie_model.dart';
import 'package:movies_2see/features/trending_series/domain/entity/trending_serie_entity.dart';
import 'package:movies_2see/features/trending_series/domain/repo/trending_series_repo.dart';

class TrendingSerieRepoImpl implements TrendingSeriesRepo {
  const TrendingSerieRepoImpl(this._connector);

  final DioConnector _connector;

  static const String _timeWindow = 'week';

  @override
  Future<List<TrendingSerieEntity>> getTrendingSeries() async {
    final response = await _connector.get(
      EndPoints.trendingSeriesUrl(_timeWindow),
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const ApiException('Respuesta inesperada de la API.');
    }
    final results = data['results'];
    if (results is! List) {
      throw const ApiException('No se pudo leer el listado de series.');
    }

    return results
        .map(
          (json) => TrendingSerieModel.fromJson(json as Map<String, dynamic>)
              .toEntity(),
        )
        .toList();
  }
}

final trendingSerieRepoProvider = Provider<TrendingSeriesRepo>((ref) {
  return TrendingSerieRepoImpl(ref.watch(dioConnectorProvider));
});
