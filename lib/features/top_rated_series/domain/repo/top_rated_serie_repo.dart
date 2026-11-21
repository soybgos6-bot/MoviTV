import 'package:movies_2see/features/top_rated_series/domain/entity/top_rated_serie_entity.dart';

abstract class TopRatedSerieRepo {
  Future<List<TopRatedSerieEntity>> getTopRatedSeries();
}
