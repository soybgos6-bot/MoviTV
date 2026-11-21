import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/data/data_source/endpoints.dart';
import 'package:movies_2see/core/dio_options/dio_connector.dart';
import 'package:movies_2see/core/errors/api_exception.dart';
import 'package:movies_2see/features/trending_movies/data/models/trending_movie_model.dart';
import 'package:movies_2see/features/trending_movies/domain/entity/trending_movie_entity.dart';
import 'package:movies_2see/features/trending_movies/domain/repo/trending_movies_repo.dart';

class TrendingMovieRepoImpl implements TrendingMoviesRepo {
  const TrendingMovieRepoImpl(this._connector);

  final DioConnector _connector;

  static const String _timeWindow = 'day';

  @override
  Future<TrendingMovieEntity> getTrendingMovie() async {
    final response = await _connector.get(
      EndPoints.trendingMoviesUrl(_timeWindow),
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const ApiException('Respuesta inesperada de la API.');
    }
    final results = data['results'];
    if (results is! List || results.isEmpty) {
      throw const ApiException('No hay peliculas en tendencia por ahora.');
    }

    final firstMovieJson = results.first as Map<String, dynamic>;
    return TrendingMovieModel.fromJson(firstMovieJson).toEntity();
  }
}

final trendingMovieRepoProvider = Provider<TrendingMoviesRepo>((ref) {
  return TrendingMovieRepoImpl(ref.watch(dioConnectorProvider));
});
