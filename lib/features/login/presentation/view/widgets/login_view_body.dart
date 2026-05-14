import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';
import 'package:movie_app/core/widgets/custom_text.dart';
import 'package:movie_app/features/login/presentation/view/widgets/login_form_section.dart';
import 'package:movie_app/features/login/presentation/view/widgets/login_listener_sec.dart';
import 'package:movie_app/generated/l10n.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            context.gapH(100),
            CustomText(
              text: s.login,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            context.gapH(24),
            const LoginFormSection(),
            const LoginListenerSec(),
          ],
        ),
      ),
    );
  }
}
