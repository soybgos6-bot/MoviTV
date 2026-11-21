import 'package:movies_2see/features/serie_details/domain/entity/serie_details_entity.dart';

abstract class SerieDetailsRepo {
  Future<SerieDetailsEntity> getSerieDetails(int id);
}
