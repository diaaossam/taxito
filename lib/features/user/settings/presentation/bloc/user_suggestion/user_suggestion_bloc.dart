import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/features/app/data/models/generic_model.dart';
import 'package:aslol/features/settings/domain/usecases/get_all_suggestion_types_use_case.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/send_suggestion_use_case.dart';

part 'user_suggestion_event.dart';

part 'user_suggestion_state.dart';

@Injectable()
class UserSuggestionBloc
    extends Bloc<UserSuggestionEvent, UserSuggestionState> {
  final GetAllSuggestionTypeUseCase getAllSuggestionTypeUseCase;
  final SendSuggestionsTypeUseCase sendSuggestionsTypeUseCase;
  List<GenericModel> suggestionsList = [];

  UserSuggestionBloc(
      this.getAllSuggestionTypeUseCase, this.sendSuggestionsTypeUseCase)
      : super(UserSuggestionInitial()) {
    on<GetAllSuggestionsType>((event, emit) async {
      emit(GetAllSuggestionTypesLoading());
      final response = await getAllSuggestionTypeUseCase();
      emit(
          response.fold((l) => GetAllSuggestionTypesFailure(error: l.msg), (r) {
        suggestionsList = r.data;
        return GetAllSuggestionTypesSuccess();
      }));
    });
    on<SendSuggestionEvent>(
      (event, emit) async {
        emit(SendSuggestionTypesLoading());
        final response = await sendSuggestionsTypeUseCase(
          id: event.id,
          other: event.other,
        );
        emit(response.fold((l) => SendSuggestionTypesFailure(error: l.msg),
            (r) => SendSuggestionTypesSuccess(msg: r.message ?? "")));
      },
    );
  }
}
