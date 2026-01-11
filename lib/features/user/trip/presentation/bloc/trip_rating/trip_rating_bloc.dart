import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/review_trip_params.dart';
import '../../../domain/usecases/send_trip_review_use_case.dart';

part 'trip_rating_event.dart';

part 'trip_rating_state.dart';

@Injectable()
class TripRatingBloc extends Bloc<TripRatingEvent, TripRatingState> {
  final SendTripReviewUseCase sendTripReviewUseCase;

  TripRatingBloc(this.sendTripReviewUseCase) : super(TripRatingInitial()) {
    on<SendTripRatingEvent>(
      (event, emit) async {
        emit(SendTripRatingLoading());
        final response =
            await sendTripReviewUseCase(reviewParams: event.tripParams);
        emit(response.fold(
          (l) => SendTripRatingFailure(message: l.msg),
          (r) => SendTripRatingSuccess(msg: r.message ?? ""),
        ));
      },
    );
  }
}
