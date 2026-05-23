import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/core/utils/constants/app_constants.dart';
import 'package:movie_app/core/utils/constants/storage_keys.dart';
import 'package:movie_app/core/utils/shared_prefrences_helper.dart';
import 'package:movie_app/features/onboarding/data/models/onboarding_model/onboarding_model.dart';
import 'package:movie_app/features/onboarding/presentation/view_model/onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());
  final PageController controller = PageController();
  final SharedPrefsHelper prefs = getIt<SharedPrefsHelper>();

  int currentIndex = 0;
  final List<OnBoardingModel> items = [
    OnBoardingModel(
      image: AppImages.onBoarding1,
      title: AppConstants.onBoarding1Title,
      description: AppConstants.onBoarding1Description,
    ),
    OnBoardingModel(
      image: AppImages.onBoarding2,
      title: AppConstants.onBoarding2Title,
      description: AppConstants.onBoarding2Description,
    ),
    OnBoardingModel(
      image: AppImages.onBoarding3,
      title: AppConstants.onBoarding3Title,
      description: AppConstants.onBoarding3Description,
    ),
    OnBoardingModel(
      image: AppImages.onBoarding4,
      title: AppConstants.onBoarding4Title,
      description: AppConstants.onBoarding4Description,
    ),
    OnBoardingModel(
      image: AppImages.onBoarding5,
      title: AppConstants.onBoarding5Title,
      description: AppConstants.onBoarding5Description,
    ),
    OnBoardingModel(
      image: AppImages.onBoarding6,
      title: AppConstants.onBoarding6Title,
    ),
  ];

Future<void> finishOnboarding( ) async {
  await prefs.setBool(StorageKeys.onboardingKey, true);
  emit(OnBoardingFinished());
}
  void changePage(int index) {
    currentIndex = index;
    emit(OnBoardingChanged(index));
  }

void nextPage() {
  if (isLastPage) return;

  controller.nextPage(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
}
void backPage() {
  if (isFirstPage) return;

  controller.previousPage(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
}

  bool get isFirstPage => currentIndex == 0;
  bool get isLastPage => currentIndex == items.length - 1;
  @override
Future<void> close() {
  controller.dispose();
  return super.close();
}
}
