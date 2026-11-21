import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/features/genres/data/repo_impl/genres_repo_impl.dart';
import 'package:movies_2see/features/home/presentation/providers/home_state.dart';
import 'package:movies_2see/features/on_air_series/data/repo_impl/on_air_serie_repo_impl.dart';
import 'package:movies_2see/features/on_air_series/domain/entity/on_air_serie_entity.dart';
import 'package:movies_2see/features/play_now_movies/data/repo_impl/play_now_movie_repo_impl.dart';
import 'package:movies_2see/features/play_now_movies/domain/entity/play_now_movie_entity.dart';
import 'package:movies_2see/features/top_rated_movies/data/repo_impl/top_rated_movie_repo_impl.dart';
import 'package:movies_2see/features/top_rated_movies/domain/entity/top_rated_movie_entity.dart';
import 'package:movies_2see/features/top_rated_series/data/repo_impl/top_rated_serie_repo_impl.dart';
import 'package:movies_2see/features/top_rated_series/domain/entity/top_rated_serie_entity.dart';
import 'package:movies_2see/features/trending_movies/data/repo_impl/trending_movie_repo_impl.dart';
import 'package:movies_2see/features/trending_movies/domain/entity/trending_movie_entity.dart';

class HomeNotifier extends AsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() => _loadHomeInfo();

  Future<HomeState> _loadHomeInfo() async {
    final results = await Future.wait<Object>([
      ref.read(trendingMovieRepoProvider).getTrendingMovie(),
      ref.read(playNowMovieRepoProvider).getPlayNowMovies(),
      ref.read(topRatedMovieRepoProvider).getTopRatedMovies(),
      ref.read(onAirSerieRepoProvider).getOnAirSeries(),
      ref.read(topRatedSerieRepoProvider).getTopRatedSeries(),
      _safeGenres(ref.read(genresRepoProvider).getMovieGenres()),
      _safeGenres(ref.read(genresRepoProvider).getTvGenres()),
    ]);

    final trendingMovie = results[0] as TrendingMovieEntity;
    final playNowMovies = results[1] as List<PlayNowMovieEntity>;
    final topRatedMovies = results[2] as List<TopRatedMovieEntity>;
    final onAirSeries = results[3] as List<OnAirSerieEntity>;
    final topRatedSeries = results[4] as List<TopRatedSerieEntity>;
    final movieGenres = results[5] as Map<int, String>;
    final tvGenres = results[6] as Map<int, String>;

    final sortedPlayNow = _sortByDate(playNowMovies);

    return HomeState(
      trendingMovie: trendingMovie,
      playNowMovies: sortedPlayNow.take(10).toList(),
      topRatedMovies: topRatedMovies.take(10).toList(),
      onAirSeries: onAirSeries.take(10).toList(),
      topRatedSeries: topRatedSeries.take(10).toList(),
      movieGenres: movieGenres,
      tvGenres: tvGenres,
      allPlayNowMovies: sortedPlayNow,
      allTopRatedMovies: topRatedMovies,
      allOnAirSeries: onAirSeries,
      allTopRatedSeries: topRatedSeries,
    );
  }

  Future<Map<int, String>> _safeGenres(Future<Map<int, String>> request) async {
    try {
      return await request;
    } catch (_) {
      return <int, String>{};
    }
  }

  List<PlayNowMovieEntity> _sortByDate(List<PlayNowMovieEntity> movies) {
    final sorted = List<PlayNowMovieEntity>.of(movies);
    sorted.sort((a, b) {
      final dateA = a.releaseDate;
      final dateB = b.releaseDate;
      if (dateA == null && dateB == null) return 0;
      if (dateA == null) return 1;
      if (dateB == null) return -1;
      return dateB.compareTo(dateA);
    });
    return sorted;
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(_loadHomeInfo);
  }
}

final homeNotifierProvider =
    AsyncNotifierProvider<HomeNotifier, HomeState>(HomeNotifier.new);
