import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/widgets/back_widget.dart';

class ErrorBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const ErrorBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 50.h,
      start: 16.w,
      child: BackWidget(onTap: onTap),
    );
  }
}
