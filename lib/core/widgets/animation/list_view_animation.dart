import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewAnimation extends StatelessWidget {
  final List<Widget> children;
  final Duration duration;
  final Curve curve;

  const ListViewAnimation({
    super.key,
    required this.children,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutQuad,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: children.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(milliseconds: duration.inMilliseconds + (index * 100)),
          curve: curve,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 30.h),
                child: child,
              ),
            );
          },
          child: children[index],
        );
      },
    );
  }
}
