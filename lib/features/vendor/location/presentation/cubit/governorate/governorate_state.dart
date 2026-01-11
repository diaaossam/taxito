part of 'governorate_bloc.dart';

@immutable
sealed class GovernorateState {}

final class GovernorateInitial extends GovernorateState {}
final class GetAllGovernorateLoading extends GovernorateState {}
final class GetAllGovernorateSuccess extends GovernorateState {
  final List<GenericModel> list;

  GetAllGovernorateSuccess({required this.list});
}
final class GetAllGovernorateFailure extends GovernorateState {}

final class GetAllRegionLoading extends GovernorateState {}
final class GetAllRegionSuccess extends GovernorateState {
  final List<GenericModel> list;

  GetAllRegionSuccess({required this.list});
}
final class GetAllRegionFailure extends GovernorateState {}
