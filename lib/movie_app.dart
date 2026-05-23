import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/core/navigation/app_routes.dart';
import 'package:movie_app/core/navigation/app_routing.dart';
import 'package:movie_app/core/theming/app_theme.dart';
    import 'package:movie_app/core/utils/constants/storage_keys.dart';
import 'package:movie_app/core/utils/shared_prefrences_helper.dart';
import 'package:movie_app/main.dart';
 
class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPrefsHelper prefs = getIt<SharedPrefsHelper>();
    final isOnboardingSeen = prefs.getBool(StorageKeys.onboardingKey) ?? false;
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
        
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
         
           initialRoute: isOnboardingSeen
              ? AppRoutes.loginView
              : AppRoutes.onBoardingView,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
