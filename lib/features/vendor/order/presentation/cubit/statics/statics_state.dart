part of 'statics_cubit.dart';

@immutable
sealed class StaticsState {}

final class StaticsInitial extends StaticsState {}
final class GetStaticsLoading extends StaticsState {}
final class GetStaticsSuccess extends StaticsState {}
final class GetStaticsFailure extends StaticsState {
  final String msg;

  GetStaticsFailure({required this.msg});
}
