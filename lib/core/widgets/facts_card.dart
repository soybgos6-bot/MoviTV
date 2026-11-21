import 'package:flutter/material.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/theme/app_radius.dart';
import 'package:movies_2see/core/theme/app_spacing.dart';
import 'package:movies_2see/core/theme/app_typography.dart';

class FactsCard extends StatelessWidget {
  const FactsCard({super.key, required this.facts});

  final List<(String, String)> facts;

  @override
  Widget build(BuildContext context) {
    if (facts.isEmpty) {
      return Text('Sin información', style: AppTypography.bodySm);
    }
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        children: [
          for (final (label, value) in facts)
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Row(
                children: [
                  Expanded(child: Text(label, style: AppTypography.bodySm)),
                  Flexible(
                    child: Text(
                      value,
                      style: AppTypography.labelLg,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
