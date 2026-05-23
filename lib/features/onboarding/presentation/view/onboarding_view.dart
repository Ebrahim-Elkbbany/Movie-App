import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/onboarding/presentation/view/widgets/onboarding_items.dart';
import 'package:movie_app/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:movie_app/features/onboarding/presentation/view_model/onboarding_state.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        final cubit = context.watch<OnBoardingCubit>();

        return Scaffold(
          body: PageView.builder(
            controller: cubit.controller,
            onPageChanged: cubit.changePage,
            itemCount: cubit.items.length,
            itemBuilder: (context, index) {
              final item = cubit.items[index];

              return OnboardingItem(
                image: item.image!,
                title: item.title!,
                description: item.description,

                isFirstPage: cubit.isFirstPage,
                isLastPage: cubit.isLastPage,

                showBackButton: cubit.currentIndex > 0,

                nextPage: () {
                  if (cubit.isLastPage) {
                    // navigate to login/
                  } else {
                    cubit.nextPage();
                  }
                },
                backPage: cubit.backPage,
              );
            },
          ),
        );
      },
    );
  }
}
