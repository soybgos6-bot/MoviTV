import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/data/data_source/endpoints.dart';
import 'package:movies_2see/core/dio_options/dio_connector.dart';
import 'package:movies_2see/core/errors/api_exception.dart';
import 'package:movies_2see/features/on_air_series/data/models/on_air_serie_model.dart';
import 'package:movies_2see/features/on_air_series/domain/entity/on_air_serie_entity.dart';
import 'package:movies_2see/features/on_air_series/domain/repo/on_air_serie_repo.dart';

class OnAirSerieRepoImpl implements OnAirSerieRepo {
  const OnAirSerieRepoImpl(this._connector);

  final DioConnector _connector;

  @override
  Future<List<OnAirSerieEntity>> getOnAirSeries() async {
    final response = await _connector.get(
      EndPoints.onAirSeriesUrl,
      queryParameters: <String, dynamic>{'page': 1},
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const ApiException('Respuesta inesperada de la API.');
    }
    final results = data['results'];
    if (results is! List) {
      throw const ApiException('No se pudo leer el listado de series en emision.');
    }

    return results
        .map(
          (json) => OnAirSerieModel.fromJson(json as Map<String, dynamic>)
              .toEntity(),
        )
        .toList();
  }
}

final onAirSerieRepoProvider = Provider<OnAirSerieRepo>((ref) {
  return OnAirSerieRepoImpl(ref.watch(dioConnectorProvider));
});
