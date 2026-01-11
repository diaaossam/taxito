part of 'governorate_bloc.dart';

@immutable
sealed class GovernorateEvent {}
class GetAllGovernorateEvent extends GovernorateEvent{}
class GetAllRegionEvent extends GovernorateEvent{
  final num id;

  GetAllRegionEvent({required this.id});
}
