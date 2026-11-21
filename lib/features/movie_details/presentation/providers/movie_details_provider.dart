import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/features/movie_details/data/repo_impl/movie_details_repo_impl.dart';
import 'package:movies_2see/features/movie_details/presentation/providers/movie_details_state.dart';

class MovieDetailsNotifier extends AsyncNotifier<MovieDetailsState> {
  MovieDetailsNotifier(this.movieId);

  final int movieId;

  @override
  Future<MovieDetailsState> build() => _loadDetails(movieId);

  Future<MovieDetailsState> _loadDetails(int id) async {
    final movieDetails =
        await ref.read(movieDetailsRepoProvider).getMovieDetails(id);

    return MovieDetailsState(
      movieDetails: movieDetails,
      genres: movieDetails.genres,
    );
  }
}

final movieDetailsProvider = AsyncNotifierProvider.autoDispose
    .family<MovieDetailsNotifier, MovieDetailsState, int>(
  MovieDetailsNotifier.new,
);
