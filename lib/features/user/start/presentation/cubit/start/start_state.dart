part of 'start_cubit.dart';

abstract class StartState extends Equatable {
  const StartState();

  @override
  List<Object> get props => [];
}

class StartInitial extends StartState {}

class InitAppLoading extends StartState {}

class InitAppSuccess extends StartState {
  final Widget widget;

  const InitAppSuccess({required this.widget});

  @override
  List<Object> get props => [widget];
}

class InitAppError extends StartState {
  final String errorMsg;

  const InitAppError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
