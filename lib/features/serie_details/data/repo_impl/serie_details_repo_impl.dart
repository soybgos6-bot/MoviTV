import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/data/data_source/endpoints.dart';
import 'package:movies_2see/core/dio_options/dio_connector.dart';
import 'package:movies_2see/core/errors/api_exception.dart';
import 'package:movies_2see/features/serie_details/data/models/serie_details_model.dart';
import 'package:movies_2see/features/serie_details/domain/entity/serie_details_entity.dart';
import 'package:movies_2see/features/serie_details/domain/repo/serie_details_repo.dart';

class SerieDetailsRepoImpl implements SerieDetailsRepo {
  const SerieDetailsRepoImpl(this._connector);

  final DioConnector _connector;

  @override
  Future<SerieDetailsEntity> getSerieDetails(int id) async {
    try {
      final response = await _connector.get(EndPoints.serieDetails(id));
      final serieDetailsModel = SerieDetailsModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      return serieDetailsModel.toEntity();
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('No se pudo cargar el detalle de la serie.');
    }
  }
}

final serieDetailsRepoProvider = Provider<SerieDetailsRepo>((ref) {
  return SerieDetailsRepoImpl(ref.watch(dioConnectorProvider));
});
