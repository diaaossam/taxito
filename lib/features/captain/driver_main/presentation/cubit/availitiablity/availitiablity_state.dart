part of 'availitiablity_cubit.dart';

@immutable
sealed class AvailitiablityState {}

final class AvailitiablityInitial extends AvailitiablityState {}
final class ChangeAvailitiablityLoading extends AvailitiablityState {}
final class ChangeAvailitiablitySuccess extends AvailitiablityState {}
final class ChangeAvailitiablityFailure extends AvailitiablityState {}
