import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/features/home/presentation/manager/movies_cubit.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/home_tab_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<MoviesCubit>()..fetchMovies(),
        child: HomeTabView(),
      ),
    );
  }
}
