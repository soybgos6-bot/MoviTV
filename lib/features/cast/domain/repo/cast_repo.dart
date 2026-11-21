import 'package:movies_2see/features/cast/domain/entity/cast_entity.dart';

abstract class CastRepo {
  Future<List<CastEntity>> getMovieCast(int movieId);
  Future<List<CastEntity>> getSerieCast(int serieId);
}
