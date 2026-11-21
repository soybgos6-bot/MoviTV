import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/data/data_source/endpoints.dart';
import 'package:movies_2see/core/dio_options/dio_connector.dart';
import 'package:movies_2see/core/errors/api_exception.dart';
import 'package:movies_2see/features/genres/domain/repo/genres_repo.dart';
import 'package:movies_2see/features/movie_details/data/models/genre_model.dart';

class GenresRepoImpl implements GenresRepo {
  const GenresRepoImpl(this._connector);

  final DioConnector _connector;

  @override
  Future<Map<int, String>> getMovieGenres() =>
      _getGenres(EndPoints.movieGenresUrl);

  @override
  Future<Map<int, String>> getTvGenres() => _getGenres(EndPoints.tvGenresUrl);

  Future<Map<int, String>> _getGenres(String url) async {
    final response = await _connector.get(url);

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const ApiException('Respuesta inesperada de la API.');
    }
    final genres = data['genres'];
    if (genres is! List) {
      throw const ApiException('No se pudo leer la lista de generos.');
    }

    final genreEntities = genres.map(
      (json) => GenreModel.fromJson(json as Map<String, dynamic>).toEntity(),
    );

    return {for (final genre in genreEntities) genre.id: genre.name};
  }
}

final genresRepoProvider = Provider<GenresRepo>((ref) {
  return GenresRepoImpl(ref.watch(dioConnectorProvider));
});
