import 'package:movies_2see/features/on_air_series/domain/entity/on_air_serie_entity.dart';

abstract class OnAirSerieRepo {
  Future<List<OnAirSerieEntity>> getOnAirSeries();
}
