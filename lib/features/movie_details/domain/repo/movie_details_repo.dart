import 'package:movies_2see/features/movie_details/domain/entity/movie_details_entity.dart';

abstract class MovieDetailsRepo {
  Future<MovieDetailsEntity> getMovieDetails(int id);
}
