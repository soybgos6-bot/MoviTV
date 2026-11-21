import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class AppRadius {
  AppRadius._();

  static double get sm => 2.w;
  static double get md => 3.w;
  static double get lg => 4.w;
  static double get xl => 6.w;

  static BorderRadius get smAll => BorderRadius.circular(sm);
  static BorderRadius get mdAll => BorderRadius.circular(md);
  static BorderRadius get lgAll => BorderRadius.circular(lg);
  static BorderRadius get xlAll => BorderRadius.circular(xl);

  static BorderRadius get pill => BorderRadius.circular(999);
}
