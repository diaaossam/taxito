part of 'complete_register_bloc.dart';

@immutable
sealed class CompleteRegisterEvent {}

class UpdateRegisterParamsEvent extends CompleteRegisterEvent {
  final RegisterParams registerParams;

  UpdateRegisterParamsEvent({
    required this.registerParams,
  });
}

class GetSupplierCategoryEvent extends CompleteRegisterEvent {

}
class DeleteAccountEvent extends CompleteRegisterEvent {

}
