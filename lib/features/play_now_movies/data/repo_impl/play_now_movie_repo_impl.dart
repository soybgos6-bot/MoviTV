import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/data/data_source/endpoints.dart';
import 'package:movies_2see/core/dio_options/dio_connector.dart';
import 'package:movies_2see/core/errors/api_exception.dart';
import 'package:movies_2see/features/play_now_movies/data/models/play_now_movie_model.dart';
import 'package:movies_2see/features/play_now_movies/domain/entity/play_now_movie_entity.dart';
import 'package:movies_2see/features/play_now_movies/domain/repo/play_now_movie_repo.dart';

class PlayNowMovieRepoImpl implements PlayNowMovieRepo {
  const PlayNowMovieRepoImpl(this._connector);

  final DioConnector _connector;

  @override
  Future<List<PlayNowMovieEntity>> getPlayNowMovies() async {
    final response = await _connector.get(
      EndPoints.playNowMoviesUrl,
      queryParameters: <String, dynamic>{'page': 1},
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const ApiException('Respuesta inesperada de la API.');
    }
    final results = data['results'];
    if (results is! List) {
      throw const ApiException('No se pudo leer la cartelera.');
    }

    return results
        .map(
          (json) => PlayNowMovieModel.fromJson(json as Map<String, dynamic>)
              .toEntity(),
        )
        .toList();
  }
}

final playNowMovieRepoProvider = Provider<PlayNowMovieRepo>((ref) {
  return PlayNowMovieRepoImpl(ref.watch(dioConnectorProvider));
});
