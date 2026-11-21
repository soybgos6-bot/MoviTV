import 'package:flutter/material.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/theme/app_radius.dart';
import 'package:movies_2see/core/theme/app_spacing.dart';
import 'package:movies_2see/core/theme/app_typography.dart';

class InfoChip extends StatelessWidget {
  const InfoChip({super.key, required this.label, this.highlighted = false});

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: highlighted
            ? AppColors.primary.withValues(alpha: 0.15)
            : AppColors.surfaceVariant,
        borderRadius: AppRadius.pill,
        border: Border.all(
          color: highlighted ? AppColors.primary : AppColors.outline,
        ),
      ),
      child: Text(
        label,
        style: AppTypography.labelLg.copyWith(
          color: highlighted ? AppColors.primary : AppColors.textPrimary,
        ),
      ),
    );
  }
}

class InfoChipList extends StatelessWidget {
  const InfoChipList({
    super.key,
    required this.labels,
    this.highlighted = false,
    this.emptyText = 'Sin información',
  });

  final List<String> labels;
  final bool highlighted;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    final items = labels.where((label) => label.trim().isNotEmpty).toList();
    if (items.isEmpty) {
      return Text(emptyText, style: AppTypography.bodySm);
    }
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final label in items)
          InfoChip(label: label, highlighted: highlighted),
      ],
    );
  }
}
