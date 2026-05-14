import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLoadingIndicator extends StatelessWidget {
  final Color color;
  const ButtonLoadingIndicator({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 20.h,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 2.w,
      ),
    );
  }
}
