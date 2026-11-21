import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/data/data_source/endpoints.dart';
import 'package:movies_2see/core/dio_options/dio_connector.dart';
import 'package:movies_2see/core/errors/api_exception.dart';
import 'package:movies_2see/features/top_rated_movies/data/models/top_rated_movie_model.dart';
import 'package:movies_2see/features/top_rated_movies/domain/entity/top_rated_movie_entity.dart';
import 'package:movies_2see/features/top_rated_movies/domain/repo/top_rated_movie_repo.dart';

class TopRatedMovieRepoImpl implements TopRatedMovieRepo {
  const TopRatedMovieRepoImpl(this._connector);

  final DioConnector _connector;

  @override
  Future<List<TopRatedMovieEntity>> getTopRatedMovies() async {
    final response = await _connector.get(
      EndPoints.topRatedMoviesUrl,
      queryParameters: <String, dynamic>{'page': 1},
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const ApiException('Respuesta inesperada de la API.');
    }
    final results = data['results'];
    if (results is! List) {
      throw const ApiException('No se pudo leer el listado de populares.');
    }

    return results
        .map(
          (json) => TopRatedMovieModel.fromJson(json as Map<String, dynamic>)
              .toEntity(),
        )
        .toList();
  }
}

final topRatedMovieRepoProvider = Provider<TopRatedMovieRepo>((ref) {
  return TopRatedMovieRepoImpl(ref.watch(dioConnectorProvider));
});
