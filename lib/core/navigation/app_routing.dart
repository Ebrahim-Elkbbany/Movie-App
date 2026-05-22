import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/core/navigation/app_routes.dart';
import 'package:movie_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:movie_app/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:movie_app/features/auth/presentation/view/forget_password_view.dart';
import 'package:movie_app/features/auth/presentation/view/login_view.dart';
import 'package:movie_app/features/auth/presentation/view/register_view.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    final name = routeSettings.name;
    try {
      switch (name) {
        case AppRoutes.loginView:
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => getIt<LoginCubit>(),
              child: const LoginView(),
            ),
          );

        case AppRoutes.registerView:
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => getIt<SignupCubit>(),
              child: const RegisterView(),
            ),
          );

        case AppRoutes.forgetPasswordView:
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => getIt<LoginCubit>(),
              child: const ForgetPasswordView(),
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
      builder: (context) => Scaffold(
        body: Center(
          child: Text('Route not found', style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
