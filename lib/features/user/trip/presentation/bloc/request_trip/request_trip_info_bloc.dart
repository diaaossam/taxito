import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/data/models/trip_model.dart';
import '../../../../../../core/services/socket/socket.dart';
import '../../../data/models/trip_price_model.dart';
import '../../../domain/entities/trip_params.dart';
import '../../../domain/usecases/make_trip_use_case.dart';

part 'request_trip_info_event.dart';

part 'request_trip_info_state.dart';

@Injectable()
class RequestTripBloc extends Bloc<RequestTripEvent, RequestTripState> {
  final MakeTripUseCase makeTripUseCase;
  final SocketService socketService;
  TripPriceModel? tripPriceModel;
  TripParams? tripParams;
  StreamSubscription? _socketSubscription;
  Timer? _searchTimeout;
  static const Duration _searchTimeoutDuration = Duration(minutes: 5);

  RequestTripBloc(this.makeTripUseCase, this.socketService)
    : super(RequestTripInfoInitial()) {
    on<MakeTripRequestEvent>((event, emit) async {
      emit(MakeTripRequestLoading());
      final response = await makeTripUseCase(tripParams: event.tripParams);
      emit(
        response.fold((l) => MakeTripRequestFailure(msg: l.msg), (r) {
          tripParams = event.tripParams;
          _startSearchingForDriver(r.data, emit);
          return MakeTripRequestSuccess(tripModel: r.data);
        }),
      );
    });

    on<StartSearchingForDriverEvent>((event, emit) async {
      _startSearchingForDriver(event.tripModel, emit);
    });

    on<DriverFoundEvent>((event, emit) async {
      emit(DriverFoundState(tripModel: event.tripModel));
    });

    on<SearchTimeoutEvent>((event, emit) async {
      emit(SearchTimeoutState());
    });

    on<CancelSearchEvent>((event, emit) async {
      //_cancelSearch();
      emit(SearchCancelledState());
    });
  }

  void _startSearchingForDriver(
    TripModel tripModel,
    Emitter<RequestTripState> emit,
  ) {
    emit(SearchingForDriverState(tripModel: tripModel));

    // Set up socket listeners for driver search
    _setupDriverSearchListeners(tripModel, emit);

    // Set timeout for search
    _searchTimeout?.cancel();
    _searchTimeout = Timer(_searchTimeoutDuration, () {
      if (!isClosed) {
        add(SearchTimeoutEvent());
      }
    });
  }

  void _setupDriverSearchListeners(
    TripModel tripModel,
    Emitter<RequestTripState> emit,
  ) {
    /*    // Listen for driver acceptance
    socketService.onEvent('trip-accepted', (data) {
      if (isClosed) return;

      final tripId = data['tripId'];
      if (tripId == tripModel.uuid) {
        add(DriverFoundEvent(tripModel: tripModel));
      }
    });

    // Listen for trip updates
    socketService.onEvent('trip-updated', (data) {
      if (isClosed) return;

      final tripId = data['tripId'];
      if (tripId == tripModel.uuid) {
        // Handle trip status updates
        final status = data['status'];
        if (status == 'accepted') {
          add(DriverFoundEvent(tripModel: tripModel));
        }
      }
    });

    // Listen for search cancellation
    socketService.onEvent('search-cancelled', (data) {
      if (isClosed) return;

      final tripId = data['tripId'];
      if (tripId == tripModel.uuid) {
        add(CancelSearchEvent());
      }
    });*/
  }

  /*  void _cancelSearch() {
    _searchTimeout?.cancel();
    _socketSubscription?.cancel();
    
    if (tripParams != null) {
      socketService.emitEvent('cancel-search', {
        //'tripId': tripParams!.tripId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    }
  }*/

  @override
  Future<void> close() {
    _searchTimeout?.cancel();
    _socketSubscription?.cancel();
    return super.close();
  }
}
