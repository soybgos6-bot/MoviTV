import 'package:flutter/material.dart';
import 'package:movies_2see/core/theme/app_colors.dart';
import 'package:movies_2see/core/theme/app_typography.dart';
import 'package:movies_2see/core/widgets/effects/animated_rating.dart';
import 'package:movies_2see/core/widgets/expandable_overview_text.dart';
import 'package:sizer/sizer.dart';

class OverviewPopularityWidget extends StatelessWidget {
  const OverviewPopularityWidget({
    super.key,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
  });

  final String overview;
  final double voteAverage;
  final int voteCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70.w,
            child: ExpandableOverviewText(movieOverview: overview),
          ),
          SizedBox(
            width: 20.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedRating(voteAverage: voteAverage),
                SizedBox(height: 0.8.h),
                Text(
                  '$voteCount votos',
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.textMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
