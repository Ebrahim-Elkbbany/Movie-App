import 'package:flutter/cupertino.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextAlign? textAlign;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: context.textTheme.bodyLarge?.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor ?? context.customColors.textPrimary,
      ),
    );
  }
}
