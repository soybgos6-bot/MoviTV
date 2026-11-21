import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_2see/core/routes/app_routes.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/theme/app_spacing.dart';
import 'package:movies_2see/core/theme/app_typography.dart';
import 'package:movies_2see/core/widgets/effects/fade_slide_in.dart';
import 'package:movies_2see/core/widgets/effects/pressable_scale.dart';
import 'package:movies_2see/core/widgets/message_scaffold.dart';
import 'package:movies_2see/features/home/presentation/widget/movie_card.dart';
import 'package:movies_2see/features/see_all/domain/entity/see_all_item.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({super.key, required this.args});

  final SeeAllArgs? args;

  @override
  Widget build(BuildContext context) {
    final data = args;
    if (data == null) {
      return const MessageScaffold(message: 'Vuelve al inicio para ver la lista.');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.title.toUpperCase(),
          style: AppTypography.headlineLg.copyWith(
            fontSize: 24,
            color: AppColors.primary,
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(AppSpacing.md),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          childAspectRatio: 0.62,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
        ),
        itemCount: data.items.length,
        itemBuilder: (context, index) {
          final item = data.items[index];
          return FadeSlideIn(
            delay: Duration(milliseconds: 60 * (index < 8 ? index : 8)),
            child: PressableScale(
              child: MovieCard(
                posterPath: item.posterPath,
                title: item.title,
                releaseDate: item.date,
                voteAverage: item.voteAverage,
                genre: item.genre,
                rank: data.showRanking ? index + 1 : null,
                onTap: () => context.push(
                  item.isSerie
                      ? AppRoutes.serieDetailsLocation(item.id)
                      : AppRoutes.movieDetailsLocation(item.id),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
