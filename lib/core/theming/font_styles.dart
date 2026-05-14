import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/font_weight_helper.dart'; // مسارك زي ما هو

class FontStyles {
  static TextStyle font50SemiBold = TextStyle(
    fontWeight: FontWeightHelper.semiBold,
    fontSize: 50.sp,
    height: 1.09,
    fontFamily: 'Cairo',
  );

  static TextStyle font20SemiBold = TextStyle(
    fontWeight: FontWeightHelper.semiBold,
    fontSize: 20.sp,
    fontFamily: 'Cairo',
  );

  static TextStyle font16Regular = TextStyle(
    fontWeight: FontWeightHelper.regular,
    fontSize: 16.sp,
    fontFamily: 'Cairo',
  );

  static TextStyle font16SemiBold = TextStyle(
    fontWeight: FontWeightHelper.semiBold,
    fontSize: 16.sp,
    fontFamily: 'Cairo',
  );

  static TextStyle font14Bold = TextStyle(
    fontWeight: FontWeightHelper.bold,
    fontSize: 14.sp,
    fontFamily: 'Cairo',
  );
}
