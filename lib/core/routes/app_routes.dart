import 'package:go_router/go_router.dart';
import 'package:movies_2see/features/home/presentation/pages/home_page.dart';
import 'package:movies_2see/features/movie_details/presentation/pages/movie_details_page.dart';
import 'package:movies_2see/features/see_all/domain/entity/see_all_item.dart';
import 'package:movies_2see/features/see_all/presentation/pages/see_all_page.dart';
import 'package:movies_2see/features/serie_details/presentation/pages/serie_details_page.dart';
import 'package:movies_2see/features/trending_movies/presentation/pages/trending_movies_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String homeName = 'home';
  static const String trendingMovies = '/trending_movies';
  static const String trendingMoviesName = 'trending_movies';
  static const String movieDetailsName = 'movie_details';

  static String movieDetailsLocation(int movieId) => '/movie_details/$movieId';

  static const String serieDetailsName = 'serie_details';

  static const String seeAll = '/see_all';

  static String serieDetailsLocation(int serieId) => '/serie_details/$serieId';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: <RouteBase>[
      GoRoute(
        path: home,
        name: homeName,
        builder: (context, state) => const HomePage(),
        routes: <RouteBase>[
          GoRoute(
            path: 'movie_details/:id',
            name: movieDetailsName,
            builder: (context, state) {
              final movieId = int.tryParse(state.pathParameters['id'] ?? '');
              return MovieDetailsPage(movieId: movieId);
            },
          ),
          GoRoute(
            path: 'see_all',
            builder: (context, state) =>
                SeeAllPage(args: state.extra as SeeAllArgs?),
          ),
          GoRoute(
            path: 'serie_details/:id',
            name: serieDetailsName,
            builder: (context, state) {
              final serieId = int.tryParse(state.pathParameters['id'] ?? '');
              return SerieDetailsPage(serieId: serieId);
            },
          ),
        ],
      ),
      GoRoute(
        path: trendingMovies,
        name: trendingMoviesName,
        builder: (context, state) => const TrendingMoviesPage(),
      ),
    ],
  );
}
