import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/features/cast/data/repo_impl/cast_repo_impl.dart';
import 'package:movies_2see/features/cast/domain/entity/cast_entity.dart';

final movieCastProvider =
    FutureProvider.autoDispose.family<List<CastEntity>, int>((ref, movieId) {
  return ref.read(castRepoProvider).getMovieCast(movieId);
});

final serieCastProvider =
    FutureProvider.autoDispose.family<List<CastEntity>, int>((ref, serieId) {
  return ref.read(castRepoProvider).getSerieCast(serieId);
});
