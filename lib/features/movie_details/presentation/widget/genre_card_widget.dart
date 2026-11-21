import 'package:flutter/material.dart';
import 'package:movies_2see/core/theme/app_spacing.dart';
import 'package:movies_2see/core/theme/app_typography.dart';
import 'package:sizer/sizer.dart';

class GenreCardWidget extends StatelessWidget {
  const GenreCardWidget({
    super.key,
    required this.genreName,
    required this.icon,
  });

  final String genreName;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 12.5.sp),
          SizedBox(width: 1.w),
          Text(
            genreName,
            style: AppTypography.labelMd.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
