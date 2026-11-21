import 'package:movies_2see/features/on_air_series/domain/entity/on_air_serie_entity.dart';
import 'package:movies_2see/features/play_now_movies/domain/entity/play_now_movie_entity.dart';
import 'package:movies_2see/features/top_rated_movies/domain/entity/top_rated_movie_entity.dart';
import 'package:movies_2see/features/top_rated_series/domain/entity/top_rated_serie_entity.dart';
import 'package:movies_2see/features/trending_movies/domain/entity/trending_movie_entity.dart';

class HomeState {
  const HomeState({
    required this.trendingMovie,
    required this.playNowMovies,
    required this.topRatedMovies,
    required this.onAirSeries,
    required this.topRatedSeries,
    required this.movieGenres,
    required this.tvGenres,
    this.allPlayNowMovies = const [],
    this.allTopRatedMovies = const [],
    this.allOnAirSeries = const [],
    this.allTopRatedSeries = const [],
  });

  final TrendingMovieEntity trendingMovie;

  final List<PlayNowMovieEntity> playNowMovies;

  final List<TopRatedMovieEntity> topRatedMovies;

  final List<OnAirSerieEntity> onAirSeries;

  final List<TopRatedSerieEntity> topRatedSeries;

  final Map<int, String> movieGenres;

  final Map<int, String> tvGenres;

  final List<PlayNowMovieEntity> allPlayNowMovies;
  final List<TopRatedMovieEntity> allTopRatedMovies;
  final List<OnAirSerieEntity> allOnAirSeries;
  final List<TopRatedSerieEntity> allTopRatedSeries;

  HomeState copyWith({
    TrendingMovieEntity? trendingMovie,
    List<PlayNowMovieEntity>? playNowMovies,
    List<TopRatedMovieEntity>? topRatedMovies,
    List<OnAirSerieEntity>? onAirSeries,
    List<TopRatedSerieEntity>? topRatedSeries,
    Map<int, String>? movieGenres,
    Map<int, String>? tvGenres,
    List<PlayNowMovieEntity>? allPlayNowMovies,
    List<TopRatedMovieEntity>? allTopRatedMovies,
    List<OnAirSerieEntity>? allOnAirSeries,
    List<TopRatedSerieEntity>? allTopRatedSeries,
  }) {
    return HomeState(
      trendingMovie: trendingMovie ?? this.trendingMovie,
      playNowMovies: playNowMovies ?? this.playNowMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      onAirSeries: onAirSeries ?? this.onAirSeries,
      topRatedSeries: topRatedSeries ?? this.topRatedSeries,
      movieGenres: movieGenres ?? this.movieGenres,
      tvGenres: tvGenres ?? this.tvGenres,
      allPlayNowMovies: allPlayNowMovies ?? this.allPlayNowMovies,
      allTopRatedMovies: allTopRatedMovies ?? this.allTopRatedMovies,
      allOnAirSeries: allOnAirSeries ?? this.allOnAirSeries,
      allTopRatedSeries: allTopRatedSeries ?? this.allTopRatedSeries,
    );
  }
}
