import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

class TransparentButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TransparentButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColorsExtension.light.buttonColor,
          elevation: 0,
          textStyle: FontStyles.font20SemiBold.copyWith(
            fontWeight: FontWeight.w600,
          ),
          side: BorderSide(
            color: AppColorsExtension.light.buttonColor,
            width: 2.w,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
