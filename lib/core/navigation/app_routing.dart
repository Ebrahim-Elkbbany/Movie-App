import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/core/navigation/app_routes.dart';
 import 'package:movie_app/features/login/presentation/view_model/login_cubit.dart';
import 'package:movie_app/features/login/presentation/view/login_view.dart';
import 'package:movie_app/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:movie_app/features/onboarding/presentation/view_model/onboarding_cubit.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    var name = routeSettings.name;
    try {
      switch (name) {
        case AppRoutes.loginView:
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginView(),
            ),
          );
      
      case AppRoutes.onBoardingView:
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => getIt<OnBoardingCubit>(),
              child: const OnboardingView(),
            ),
          );
      
        default:
          return _errorRoute();
      }
    } catch (e) {
      return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Material(
          child: Container(
            color: Colors.red,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Error! You Have Navigated To A Wrong Route. Or Navigated With Wrong Arguments',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
