import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';

class TextFieldPrefixIcon extends StatelessWidget {
  final IconData icon;

  const TextFieldPrefixIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 20.sp,
      color: context.customColors.iconColor,
    );
  }
}
