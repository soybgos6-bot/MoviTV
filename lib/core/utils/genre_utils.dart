String genreNames(
  List<int> genreIds,
  Map<int, String> genres, {
  int max = 2,
}) {
  return genreIds
      .map((id) => genres[id])
      .whereType<String>()
      .take(max)
      .join(' • ');
}
