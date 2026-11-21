import 'package:flutter/material.dart';
import 'package:movies_2see/core/constants/app_env.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/widgets/movie_poster.dart';
import 'package:movies_2see/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:sizer/sizer.dart';

/// Cabecera del detalle: imagen grande de fondo (backdrop) que se encoge
/// al hacer scroll, con un degradado hacia el color de fondo de la app.
class MovieDetailsHeader extends StatelessWidget {
  const MovieDetailsHeader({super.key, required this.movie});

  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) {
    // Preferimos el backdrop (horizontal) en tamaño original;
    // si no tiene, usamos el poster.
    final backdrop = movie.backdropPath;
    final poster = movie.posterPath;
    final imageUrl = backdrop != null
        ? '${AppEnv.imgOriginal}$backdrop'
        : poster != null
            ? '${AppEnv.imgW500}$poster'
            : null;

    return SliverAppBar(
      expandedHeight: 38.h,
      pinned: true,
      backgroundColor: AppColors.background,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            MoviePoster(url: imageUrl),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    AppColors.background,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
