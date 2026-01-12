part of 'on_boarding_cubit.dart';

@immutable
sealed class OnBoardingState {}

final class OnBoardingInitial extends OnBoardingState {}

class LastPageView extends OnBoardingState {
  final bool isLastPageView;

  LastPageView({required this.isLastPageView});
}

class StartAppState extends OnBoardingState {}

class GetIntroDataLoading extends OnBoardingState {}

class GetIntroDataSuccess extends OnBoardingState {
  final List<IntroModel> intro;

  GetIntroDataSuccess({required this.intro});
}

class GetIntroDataFailure extends OnBoardingState {
  final String errorMsg;

  GetIntroDataFailure({required this.errorMsg});
}
