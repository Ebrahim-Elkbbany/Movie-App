import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  T? getThemeExtension<T>() => theme.extension<T>();

  AppColorsExtension get customColors => getThemeExtension<AppColorsExtension>()!;

  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  Widget gapH(double h) => SizedBox(height: h.h);
  Widget gapW(double w) => SizedBox(width: w.w);

  bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';
}
