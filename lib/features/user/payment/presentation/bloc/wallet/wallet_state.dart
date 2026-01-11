part of 'wallet_cubit.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}
final class GetAllTransactionLoading extends WalletState {}
final class GetAllTransactionSuccess extends WalletState {
  final List<TransactionModel> list;

  GetAllTransactionSuccess({required this.list});
}
final class GetAllTransactionFailure extends WalletState {
  final String msg;

  GetAllTransactionFailure({required this.msg});
}


final class GetWalletBalanceLoading extends WalletState {}
final class GetWalletBalanceSuccess extends WalletState {
  final num balance;

  GetWalletBalanceSuccess({required this.balance});
}
final class GetWalletBalanceFailure extends WalletState {
  final String msg;

  GetWalletBalanceFailure({required this.msg});
}
