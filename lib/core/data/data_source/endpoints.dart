class EndPoints {
  EndPoints._();

  static const String playNowMoviesUrl = '/movie/now_playing';
  static const String topRatedMoviesUrl = '/movie/top_rated';

  static const String onAirSeriesUrl = '/tv/on_the_air';
  static const String topRatedSeriesUrl = '/tv/top_rated';

  static const String movieGenresUrl = '/genre/movie/list';
  static const String tvGenresUrl = '/genre/tv/list';

  static String trendingMoviesUrl(String timeWindow) =>
      '/trending/movie/$timeWindow';

  static String trendingSeriesUrl(String timeWindow) =>
      '/trending/tv/$timeWindow';

  static String movieDetails(int id) => '/movie/$id';

  static String movieCredits(int id) => '/movie/$id/credits';

  static String serieDetails(int id) => '/tv/$id';

  static String serieCredits(int id) => '/tv/$id/credits';
}
