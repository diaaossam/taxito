part of 'my_address_cubit.dart';

@immutable
sealed class MyAddressState {}

final class MyAddressInitial extends MyAddressState {}

final class GetMyAddressLoading extends MyAddressState {}

final class GetMyAddressSuccess extends MyAddressState {}

final class GetMyAddressFailure extends MyAddressState {
  final String msg;

  GetMyAddressFailure({required this.msg});
}

final class MakeAddressDefaultLoading extends MyAddressState {}

final class MakeAddressDefaultSuccess extends MyAddressState {
  final String msg;
  final MyAddress myAddress;

  MakeAddressDefaultSuccess({required this.msg, required this.myAddress});

}

final class MakeAddressDefaultFailure extends MyAddressState {
  final String msg;

  MakeAddressDefaultFailure({required this.msg});
}


final class DeleteAddressLoading extends MyAddressState {}

final class DeleteAddressSuccess extends MyAddressState {
  final String msg;

  DeleteAddressSuccess({required this.msg});

}

final class DeleteAddressFailure extends MyAddressState {
  final String msg;

  DeleteAddressFailure({required this.msg});
}


final class GetLocationCostLoading extends MyAddressState {}

final class GetLocationCostFailure extends MyAddressState {
  final String msg;

  GetLocationCostFailure({required this.msg});
}

final class GetLocationCostSuccess extends MyAddressState {
  final num cost;

  GetLocationCostSuccess({required this.cost});
}