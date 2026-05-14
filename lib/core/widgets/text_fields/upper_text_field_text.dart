import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/core/widgets/custom_text.dart';

class UpperTextFieldText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const UpperTextFieldText({
    super.key,
    required this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: text,
          textColor: textColor ?? context.customColors.textPrimary,
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: fontSize ?? 14.sp,
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
