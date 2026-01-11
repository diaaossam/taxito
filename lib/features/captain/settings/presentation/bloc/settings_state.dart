part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class GetAppSettingsLoading extends SettingsState {}

class GetAppSettingsSuccess extends SettingsState {
  final SettingsModel settingsModel;

  const GetAppSettingsSuccess({required this.settingsModel});

  @override
  List<Object> get props => [settingsModel];
}

class GetAppSettingsFailure extends SettingsState {
  final String errorMsg;

  const GetAppSettingsFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
