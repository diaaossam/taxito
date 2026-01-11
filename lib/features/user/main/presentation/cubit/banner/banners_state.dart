part of 'banners_cubit.dart';

@immutable
sealed class BannersState {}

final class BannersInitial extends BannersState {}

final class GetBannersLoading extends BannersState {}
final class GetBannersSuccess extends BannersState {
  final List<BannersModel> banners;

  GetBannersSuccess({required this.banners});
}
final class GetBannersFailure extends BannersState {
  final String msg;

  GetBannersFailure({required this.msg});
}

