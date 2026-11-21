import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class AppSpacing {
  AppSpacing._();

  static double get xs => 1.w;
  static double get sm => 2.w;
  static double get md => 4.w;
  static double get lg => 6.w;
  static double get xl => 8.w;
  static double get xxl => 12.w;

  static EdgeInsets get screenPadding => EdgeInsets.symmetric(horizontal: md);
}
