import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/data/models/main_location_data.dart';
import '../../data/models/saved_location_model.dart';
import '../../data/models/suggestion_model.dart';
import '../../domain/usecases/get_place_details_by_place_id_use_case.dart';

part 'location_state.dart';

@Injectable()
class LocationCubit extends Cubit<LocationState> {
  final GetPlaceDetailsByPlaceIdUseCase getPlaceDetailsByPlaceIdUseCase;
  List<SuggestionModel> suggestionList = [];

  LocationCubit(
    this.getPlaceDetailsByPlaceIdUseCase,
  ) : super(LocationInitial());

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
