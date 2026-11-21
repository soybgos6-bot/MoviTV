import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/data/data_source/endpoints.dart';
import 'package:movies_2see/core/dio_options/dio_connector.dart';
import 'package:movies_2see/core/errors/api_exception.dart';
import 'package:movies_2see/features/top_rated_series/data/models/top_rated_serie_model.dart';
import 'package:movies_2see/features/top_rated_series/domain/entity/top_rated_serie_entity.dart';
import 'package:movies_2see/features/top_rated_series/domain/repo/top_rated_serie_repo.dart';

class TopRatedSerieRepoImpl implements TopRatedSerieRepo {
  const TopRatedSerieRepoImpl(this._connector);

  final DioConnector _connector;

  @override
  Future<List<TopRatedSerieEntity>> getTopRatedSeries() async {
    final response = await _connector.get(
      EndPoints.topRatedSeriesUrl,
      queryParameters: <String, dynamic>{'page': 1},
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const ApiException('Respuesta inesperada de la API.');
    }
    final results = data['results'];
    if (results is! List) {
      throw const ApiException('No se pudo leer el listado de series mejor calificadas.');
    }

    return results
        .map(
          (json) => TopRatedSerieModel.fromJson(json as Map<String, dynamic>)
              .toEntity(),
        )
        .toList();
  }
}

final topRatedSerieRepoProvider = Provider<TopRatedSerieRepo>((ref) {
  return TopRatedSerieRepoImpl(ref.watch(dioConnectorProvider));
});
