part of 'user_suggestion_bloc.dart';

@immutable
sealed class UserSuggestionState {}

final class UserSuggestionInitial extends UserSuggestionState {}


class GetAllSuggestionTypesLoading extends UserSuggestionState {}
class GetAllSuggestionTypesFailure extends UserSuggestionState {
  final String error;

  GetAllSuggestionTypesFailure({required this.error});
}
class GetAllSuggestionTypesSuccess extends UserSuggestionState {}


class SendSuggestionTypesLoading extends UserSuggestionState {}
class SendSuggestionTypesFailure extends UserSuggestionState {
  final String error;

  SendSuggestionTypesFailure({required this.error});
}
class SendSuggestionTypesSuccess extends UserSuggestionState {
  final String msg;

  SendSuggestionTypesSuccess({required this.msg});
}