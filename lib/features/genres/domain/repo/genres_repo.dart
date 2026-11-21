abstract class GenresRepo {
  Future<Map<int, String>> getMovieGenres();
  Future<Map<int, String>> getTvGenres();
}
