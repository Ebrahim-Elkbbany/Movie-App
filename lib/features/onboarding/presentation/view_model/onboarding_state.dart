sealed class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingChanged extends OnBoardingState {
  final int index;
  OnBoardingChanged(this.index);
}
class OnBoardingFinished extends OnBoardingState {}