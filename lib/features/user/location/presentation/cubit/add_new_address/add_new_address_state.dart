part of 'add_new_address_cubit.dart';

@immutable
sealed class AddNewAddressState {}

final class AddNewAddressInitial extends AddNewAddressState {}
final class AddNewAddressLoading extends AddNewAddressState {}
final class AddNewAddressSuccess extends AddNewAddressState {
  final String msg;

  AddNewAddressSuccess({required this.msg});
}
final class AddNewAddressFailure extends AddNewAddressState {
  final String msg;

  AddNewAddressFailure({required this.msg});
}
