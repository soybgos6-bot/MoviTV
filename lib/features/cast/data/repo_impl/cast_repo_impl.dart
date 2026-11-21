import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/data/data_source/endpoints.dart';
import 'package:movies_2see/core/dio_options/dio_connector.dart';
import 'package:movies_2see/core/errors/api_exception.dart';
import 'package:movies_2see/features/cast/data/models/cast_model.dart';
import 'package:movies_2see/features/cast/domain/entity/cast_entity.dart';
import 'package:movies_2see/features/cast/domain/repo/cast_repo.dart';

class CastRepoImpl implements CastRepo {
  const CastRepoImpl(this._connector);

  final DioConnector _connector;

  static const int _maxActors = 20;

  @override
  Future<List<CastEntity>> getMovieCast(int movieId) =>
      _getCast(EndPoints.movieCredits(movieId));

  @override
  Future<List<CastEntity>> getSerieCast(int serieId) =>
      _getCast(EndPoints.serieCredits(serieId));

  Future<List<CastEntity>> _getCast(String url) async {
    try {
      final response = await _connector.get(url);
      final data = response.data as Map<String, dynamic>;
      final cast = data['cast'] as List<dynamic>? ?? const [];

      final actors = cast
          .map((json) => CastModel.fromJson(json as Map<String, dynamic>))
          .where((actor) => actor.knownForDepartment == 'Acting')
          .map((actor) => actor.toEntity())
          .toList()
        ..sort((a, b) => a.order.compareTo(b.order));

      return actors.take(_maxActors).toList();
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('No se pudo cargar el reparto.');
    }
  }
}

final castRepoProvider = Provider<CastRepo>((ref) {
  return CastRepoImpl(ref.watch(dioConnectorProvider));
});
