import 'package:movies_2see/features/trending_movies/domain/entity/trending_movie_entity.dart';

abstract class TrendingMoviesRepo {
  Future<TrendingMovieEntity> getTrendingMovie();
}
