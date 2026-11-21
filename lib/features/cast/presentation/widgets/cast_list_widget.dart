import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/theme/app_typography.dart';
import 'package:movies_2see/core/widgets/effects/fade_slide_in.dart';
import 'package:movies_2see/core/widgets/effects/pressable_scale.dart';
import 'package:movies_2see/features/cast/domain/entity/cast_entity.dart';
import 'package:movies_2see/features/cast/presentation/widgets/cast_card_widget.dart';
import 'package:sizer/sizer.dart';

class CastListWidget extends StatelessWidget {
  const CastListWidget({super.key, required this.cast});

  final AsyncValue<List<CastEntity>> cast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CastCardWidget.cardHeight(),
      child: cast.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('No se pudo cargar el reparto.',
              style: AppTypography.bodySm),
        ),
        data: (actors) {
          if (actors.isEmpty) {
            return Center(
              child: Text('Sin información del reparto.',
                  style: AppTypography.bodySm),
            );
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(right: 5.w),
            itemCount: actors.length,
            separatorBuilder: (context, index) => SizedBox(width: 3.w),
            itemBuilder: (context, index) => FadeSlideIn(
              delay: Duration(milliseconds: 90 * (index < 6 ? index : 6)),
              offset: const Offset(0.4, 0),
              child: PressableScale(
                child: CastCardWidget(actor: actors[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
