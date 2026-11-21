import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/data/data_source/endpoints.dart';
import 'package:movies_2see/core/dio_options/dio_connector.dart';
import 'package:movies_2see/core/errors/api_exception.dart';
import 'package:movies_2see/features/movie_details/data/models/movie_details_model.dart';
import 'package:movies_2see/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies_2see/features/movie_details/domain/repo/movie_details_repo.dart';

class MovieDetailsRepoImpl implements MovieDetailsRepo {
  const MovieDetailsRepoImpl(this._connector);

  final DioConnector _connector;

  @override
  Future<MovieDetailsEntity> getMovieDetails(int id) async {
    try {
      final response = await _connector.get(EndPoints.movieDetails(id));

      final movieDetailsModel = MovieDetailsModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      return movieDetailsModel.toEntity();
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('No se pudo cargar el detalle de la película.');
    }
  }
}

final movieDetailsRepoProvider = Provider<MovieDetailsRepo>((ref) {
  return MovieDetailsRepoImpl(ref.watch(dioConnectorProvider));
});
