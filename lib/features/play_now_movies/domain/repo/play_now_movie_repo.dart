import 'package:movies_2see/features/play_now_movies/domain/entity/play_now_movie_entity.dart';

abstract class PlayNowMovieRepo {
  Future<List<PlayNowMovieEntity>> getPlayNowMovies();
}
