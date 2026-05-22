import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipes/core/helpers/cache_helper.dart';
import 'package:food_recipes/core/helpers/extensions.dart';
import 'package:food_recipes/core/helpers/responsive_spacing.dart';
import 'package:food_recipes/core/routing/routes.dart';
import 'package:food_recipes/core/theming/font_styles.dart';
import 'package:food_recipes/features/profile/presentation/manager/theme_cubit/theme_cubit.dart';


class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          desc: 'Verifying Email Successes',
        ).show();
      });
      timer?.cancel();
      await CacheHelper.saveData(key: 'token', value: FirebaseAuth.instance.currentUser!.uid);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.pushNamedAndRemoveUntil(Routes.layoutView, predicate: (route) => false,);
      });

    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLightTheme =ThemeCubit.get(context).isLightTheme;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpacer(65),
               Center(
                child: Text(
                  'Check your \n Email',
                  textAlign: TextAlign.center,
                  style: FontStyles.font16WhiteSemiBold.copyWith(
                    color: isLightTheme ? Colors.black : null,
                  ),
                ),
              ),
              verticalSpacer(8),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 32.0.w),
                child: Center(
                  child: Text(
                    'We have sent you a Email on  ${widget.email}',
                    textAlign: TextAlign.center,
                    style: FontStyles.font13WhiteD9Regular
                  ),
                ),
              ),
             verticalSpacer(16),
              const Center(child: CircularProgressIndicator()),
              verticalSpacer(8),
               Padding(
                padding: EdgeInsets
                    .symmetric(horizontal: 32.0.w),
                child:  Center(
                  child: Text(
                    'Verifying email....',
                    textAlign: TextAlign.center,
                    style: FontStyles.font16WhiteSemiBold.copyWith(
                      color: isLightTheme ? Colors.black : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 57),
              Padding(
                padding: const EdgeInsets
                    .symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  child: const Text('Resend'),
                  onPressed: () {
                    try {
                      FirebaseAuth.instance.currentUser
                          ?.sendEmailVerification();
                    } catch (e) {
                      debugPrint('$e');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}