part of 'complete_register_bloc.dart';

@immutable
sealed class CompleteRegisterEvent {}

class OnPageChangedEvent extends CompleteRegisterEvent {
  final int index;

  OnPageChangedEvent({required this.index});
}

class UpdateRegisterParamsEvent extends CompleteRegisterEvent {
  final RegisterParams registerParams;
  final int nextStep;

  UpdateRegisterParamsEvent({
    required this.registerParams,
    required this.nextStep,
  });
}

class CompleteRegisterSuccessEvent extends CompleteRegisterEvent {
  final RegisterParams registerParams;

  CompleteRegisterSuccessEvent({
    required this.registerParams,
  });
}

class DeleteAccountEvent extends CompleteRegisterEvent {

}
