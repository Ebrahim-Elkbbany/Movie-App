abstract class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingChanged extends OnBoardingState {  final int index;
  OnBoardingChanged(this.index);}