part of 'user_suggestion_bloc.dart';

@immutable
sealed class UserSuggestionEvent {}

class GetAllSuggestionsType extends UserSuggestionEvent {}

class SendSuggestionEvent extends UserSuggestionEvent {
  final String? other;
  final int id;

  SendSuggestionEvent({
    required this.other,
    required this.id,
  });
}
