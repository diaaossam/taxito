import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/generated/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:taxito/features/captain/start/data/models/intro_model.dart';
import 'package:taxito/features/captain/start/domain/usecases/get_intro_use_case.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'on_boarding_state.dart';

@LazySingleton()
class OnBoardingCubit extends Cubit<OnBoardingState> {
  final SharedPreferences sharedPreferences;
  final GetIntroDataUseCase getIntroDataUseCase;

  OnBoardingCubit(
    this.getIntroDataUseCase,
    this.sharedPreferences,
  ) : super(OnBoardingInitial());

  bool isLast = false;

  void changePageViewState(bool from) {
    isLast = from;
    emit(LastPageView(isLastPageView: from));
  }

  var boardController = PageController();

  Future<void> submit() async {
    sharedPreferences.setBool(AppStrings.onBoarding, true);
    emit(StartAppState());
  }

  List<IntroModel> introList = [];

  Future<void> getIntroData() async {
    emit(GetIntroDataLoading());
    introList = [
      IntroModel(
          id: 1,
          title: S.current.onBoardingTitle1,
          description: S.current.onBoardingBody1,
          image: Assets.images.onBoarding1.path),
      IntroModel(
          id: 2,
          title: S.current.onBoardingTitle2,
          description: S.current.onBoardingBody2,
          image: Assets.images.onBoarding2.path),
    ];
    emit(GetIntroDataSuccess(intro: introList));
/*    introList.clear();
    emit(GetIntroDataLoading());
    final response = await getIntroDataUseCase();
    emit(response.fold((l) => GetIntroDataFailure(errorMsg: l.msg), (r) {
      introList = r.data;
      return GetIntroDataSuccess(intro: r.data);
    }));*/
  }
}
