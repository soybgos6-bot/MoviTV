class SeeAllItem {
  const SeeAllItem({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.date,
    required this.voteAverage,
    required this.genre,
    required this.isSerie,
  });

  final int id;
  final String title;
  final String? posterPath;
  final DateTime? date;
  final double voteAverage;
  final String genre;

  final bool isSerie;
}

class SeeAllArgs {
  const SeeAllArgs({
    required this.title,
    required this.items,
    this.showRanking = false,
  });

  final String title;
  final List<SeeAllItem> items;

  final bool showRanking;
}
