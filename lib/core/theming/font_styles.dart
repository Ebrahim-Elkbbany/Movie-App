import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/font_weight_helper.dart';

class FontStyles {
  static TextStyle font50SemiBold = TextStyle(
    fontWeight: FontWeightHelper.semiBold,
    fontSize: 50.sp,
    height: 1.09,
    fontFamily: 'Cairo',
  );

  static TextStyle font24Bold = TextStyle(
    fontWeight: FontWeightHelper.bold,
    fontSize: 24.sp,
    fontFamily: 'Cairo',
  );

  static TextStyle font20SemiBold = TextStyle(
    fontWeight: FontWeightHelper.semiBold,
    fontSize: 20.sp,
    fontFamily: 'Cairo',
  );

  static TextStyle font18SemiBold = TextStyle(
    fontWeight: FontWeightHelper.semiBold,
    fontSize: 18.sp,
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

  static TextStyle font14Regular = TextStyle(
    fontWeight: FontWeightHelper.regular,
    fontSize: 14.sp,
    fontFamily: 'Cairo',
  );

  static TextStyle font14SemiBold = TextStyle(
    fontWeight: FontWeightHelper.semiBold,
    fontSize: 14.sp,
    fontFamily: 'Cairo',
  );

  static TextStyle font14Bold = TextStyle(
    fontWeight: FontWeightHelper.bold,
    fontSize: 14.sp,
    fontFamily: 'Cairo',
  );

  static TextStyle font12Regular = TextStyle(
    fontWeight: FontWeightHelper.regular,
    fontSize: 12.sp,
    fontFamily: 'Cairo',
  );

  static TextStyle font12SemiBold = TextStyle(
    fontWeight: FontWeightHelper.semiBold,
    fontSize: 12.sp,
    fontFamily: 'Cairo',
  );

  static TextStyle get font14 => font14Regular;
  static TextStyle get font16Bold => TextStyle(
    fontWeight: FontWeightHelper.bold,
    fontSize: 16.sp,
    fontFamily: 'Cairo',
  );
  static TextStyle get font18Bold => TextStyle(
    fontWeight: FontWeightHelper.bold,
    fontSize: 18.sp,
    fontFamily: 'Cairo',
  );
}
