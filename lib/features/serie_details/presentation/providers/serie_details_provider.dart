import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/features/serie_details/data/repo_impl/serie_details_repo_impl.dart';
import 'package:movies_2see/features/serie_details/presentation/providers/serie_details_state.dart';

class SerieDetailsNotifier extends AsyncNotifier<SerieDetailsState> {
  SerieDetailsNotifier(this.serieId);

  final int serieId;

  @override
  Future<SerieDetailsState> build() async {
    final serieDetails =
        await ref.read(serieDetailsRepoProvider).getSerieDetails(serieId);
    return SerieDetailsState(
      serieDetails: serieDetails,
      genres: serieDetails.genres,
    );
  }
}

final serieDetailsProvider = AsyncNotifierProvider.autoDispose
    .family<SerieDetailsNotifier, SerieDetailsState, int>(
  SerieDetailsNotifier.new,
);
