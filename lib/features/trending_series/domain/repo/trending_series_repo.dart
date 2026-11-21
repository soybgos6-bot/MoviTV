import 'package:movies_2see/features/trending_series/domain/entity/trending_serie_entity.dart';

abstract class TrendingSeriesRepo {
  Future<List<TrendingSerieEntity>> getTrendingSeries();
}
