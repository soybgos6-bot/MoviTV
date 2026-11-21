import 'package:movies_2see/features/top_rated_movies/domain/entity/top_rated_movie_entity.dart';

abstract class TopRatedMovieRepo {
  Future<List<TopRatedMovieEntity>> getTopRatedMovies();
}
