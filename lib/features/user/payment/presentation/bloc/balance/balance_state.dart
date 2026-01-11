part of 'balance_cubit.dart';

@immutable
sealed class BalanceState {}

final class BalanceInitial extends BalanceState {}
final class AddBalanceLoading extends BalanceState {}
final class AddBalanceSuccess extends BalanceState {

}
final class AddBalanceFailure extends BalanceState {
  final String  msg;

  AddBalanceFailure({required this.msg});
}
