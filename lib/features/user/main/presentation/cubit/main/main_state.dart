part of 'main_cubit.dart';

abstract class MainState {
  const MainState();

}
class MainInitial extends MainState {}
class ChangeCurrentIndexState extends MainState {
  final int index;

  ChangeCurrentIndexState({required this.index});
}
class RefreshScreenState extends MainState {}
class ResetScreenState extends MainState {}

class RefreshHome extends MainState {}
class RefreshPremium extends MainState {}
class UpdateCountSuccess extends MainState {}
