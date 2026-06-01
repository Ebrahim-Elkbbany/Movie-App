import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/core/navigation/app_routes.dart';
import 'package:movie_app/core/utils/constants/storage_keys.dart';
import 'package:movie_app/core/utils/shared_prefrences_helper.dart';
import 'package:movie_app/features/search/presentation/manager/search_cubit.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/movie_details_view.dart';
import 'package:movie_app/features/home/presentation/view/home_view.dart';
import 'package:movie_app/features/home/presentation/manager/category_movies_cubit.dart';
import 'package:movie_app/features/home/presentation/view/category_movies_view.dart';
import 'package:movie_app/features/main_layout/presentation/view/main_view.dart';
import 'package:movie_app/features/search/presentation/view/search_view.dart';
import 'package:movie_app/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:movie_app/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:movie_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:movie_app/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:movie_app/features/auth/presentation/view/forget_password_view.dart';
import 'package:movie_app/features/auth/presentation/view/login_view.dart';
import 'package:movie_app/features/auth/presentation/view/register_view.dart';
import 'package:movie_app/features/profile/presentation/view/profile_view.dart';
import 'package:movie_app/features/profile/presentation/view/edit_profile_view.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/explore/presentation/view/explore_view.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    final name = routeSettings.name;
    try {
      switch (name) {
        case AppRoutes.initialRoute:
          final prefs = getIt<SharedPrefsHelper>();
          final isOnboardingSeen =
              prefs.getBool(StorageKeys.onboardingKey) ?? false;
          final user = FirebaseAuth.instance.currentUser;

          if (!isOnboardingSeen) {
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => getIt<OnBoardingCubit>(),
                child: const OnboardingView(),
              ),
            );
          } else if (user != null) {
            return MaterialPageRoute(builder: (context) => const MainView());
          } else {
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: const LoginView(),
              ),
            );
          }

        case AppRoutes.onBoardingView:
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => getIt<OnBoardingCubit>(),
              child: const OnboardingView(),
            ),
          );

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
        case AppRoutes.mainView:
          return MaterialPageRoute(builder: (context) => const MainView());

        case AppRoutes.homeView:
          return MaterialPageRoute(builder: (context) => const HomeView());
        case AppRoutes.detailsView:
          final id = routeSettings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => MovieDetailsView(id: id),
          );

        case AppRoutes.categoryMoviesView:
          final genre = routeSettings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => getIt<CategoryMoviesCubit>()..getMoviesByGenre(genre),
              child: CategoryMoviesView(genre: genre),
            ),
          );

     case AppRoutes.searchView:
  return MaterialPageRoute(
    builder: (context) => BlocProvider(
      create: (_) => getIt<SearchCubit>(),
      child: const SearchViewTab(),
    ),
  );
        case AppRoutes.profileView:
          return MaterialPageRoute(builder: (context) => const ProfileView());
        case AppRoutes.editProfileView:
          final userModel = routeSettings.arguments as UserModel;
          return MaterialPageRoute(
            builder: (context) => EditProfileView(userModel: userModel),
          );
        case AppRoutes.exploreView:
          return MaterialPageRoute(
            builder: (context) => const ExploreView(),
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
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Route not found', style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
