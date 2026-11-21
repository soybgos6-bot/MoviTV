import 'package:flutter/material.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/widgets/effects/shimmer_box.dart';
import 'package:sizer/sizer.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, required this.url, this.fit = BoxFit.cover});

  final String? url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final placeholder = ColoredBox(
      color: AppColors.surfaceVariant,
      child: Center(
        child: Icon(Icons.movie_outlined, color: AppColors.textMuted, size: 12.w),
      ),
    );

    final posterUrl = url;
    if (posterUrl == null) return placeholder;

    return Image.network(
      posterUrl,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        return progress == null ? child : const ShimmerBox();
      },
      errorBuilder: (context, error, stackTrace) => placeholder,
    );
  }
}
