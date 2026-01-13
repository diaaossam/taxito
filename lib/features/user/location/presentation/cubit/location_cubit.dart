import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/models/main_location_data.dart';
import '../../data/models/response/suggestion_model.dart';
import '../../domain/usecases/get_google_suggestion_use_case.dart';
import '../../domain/usecases/get_place_details_by_place_id_use_case.dart';

part 'location_state.dart';

@Injectable()
class LocationCubit extends Cubit<LocationState> {
  final GetGoogleSuggestUseCase getGoogleSuggestUseCase;
  final GetPlaceDetailsByPlaceIdUseCase getPlaceDetailsByPlaceIdUseCase;
  List<SuggestionModel> suggestionList = [];

  LocationCubit(
    this.getGoogleSuggestUseCase,
    this.getPlaceDetailsByPlaceIdUseCase,
  ) : super(LocationInitial());

  Future<void> fetchSuggestion({required String query}) async {
    emit(GetSuggestMapLoading());
    final response = await getGoogleSuggestUseCase(query: query);
    emit(response.fold(
      (l) => GetSuggestMapFailure(errorMsg: l.msg),
      (r) => GetSuggestMapSuccess(list: r.data),
    ));
  }

  Future<void> getPlaceDetailsByPlaceId(
      {required SuggestionModel suggestionModel}) async {
    suggestionList.add(suggestionModel);
    emit(GetPlaceDetailsByPlaceIdLoading());
    final response =
        await getPlaceDetailsByPlaceIdUseCase(suggestionModel: suggestionModel);
    emit(response.fold((l) => GetPlaceDetailsByPlaceIdFailure(errorMsg: l.msg),
        (r) => GetPlaceDetailsByPlaceIdSuccess(location: r.data)));
  }
}
