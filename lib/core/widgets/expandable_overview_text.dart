import 'package:flutter/material.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/theme/app_typography.dart';

class ExpandableOverviewText extends StatefulWidget {
  const ExpandableOverviewText({
    super.key,
    required this.movieOverview,
    this.trimLines = 3,
  });

  final String movieOverview;

  final int trimLines;

  @override
  State<ExpandableOverviewText> createState() => _ExpandableOverviewTextState();
}

class _ExpandableOverviewTextState extends State<ExpandableOverviewText> {
  bool isExpanded = false;

  TextStyle get _textStyle => AppTypography.bodyMd.copyWith(
        color: Colors.white,
        height: 1.4,
        letterSpacing: 0.3,
      );

  @override
  Widget build(BuildContext context) {
    final text = widget.movieOverview.trim().isEmpty
        ? 'Sin sinopsis disponible.'
        : widget.movieOverview.trim();

    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(text: text, style: _textStyle),
          maxLines: widget.trimLines,
          textDirection: Directionality.of(context),
          textScaler: MediaQuery.textScalerOf(context),
        )..layout(maxWidth: constraints.maxWidth);
        final isLongText = painter.didExceedMaxLines;
        painter.dispose();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              alignment: Alignment.topLeft,
              child: Text(
                text,
                maxLines: isExpanded ? null : widget.trimLines,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: _textStyle,
              ),
            ),
            if (isLongText) ...[
              const SizedBox(height: 4),
              TextButton(
                onPressed: () => setState(() => isExpanded = !isExpanded),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isExpanded ? 'Ver menos' : 'Ver más',
                      style: AppTypography.labelMd.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
