import 'package:movies_2see/features/movie_details/domain/entity/genre_entity.dart';
import 'package:movies_2see/features/movie_details/domain/entity/movie_details_entity.dart';

class MovieDetailsState {
  const MovieDetailsState({
    required this.movieDetails,
    required this.genres,
  });

  final MovieDetailsEntity movieDetails;
  final List<GenreEntity> genres;

  MovieDetailsState copyWith({
    MovieDetailsEntity? movieDetails,
    List<GenreEntity>? genres,
  }) {
    return MovieDetailsState(
      movieDetails: movieDetails ?? this.movieDetails,
      genres: genres ?? this.genres,
    );
  }
}
