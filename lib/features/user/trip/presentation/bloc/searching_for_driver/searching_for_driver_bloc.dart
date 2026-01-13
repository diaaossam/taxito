import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';
import '../../../../../../core/data/models/trip_model.dart';
import '../../../../../../core/enum/trip_status_enum.dart';
import '../../../../../../core/services/socket/socket.dart';
import '../../../domain/usecases/cancel_trip_use_case.dart';
import '../../../domain/usecases/get_trip_by_id_use_case.dart';
import '../../../domain/usecases/get_trip_by_uuid_use_case.dart';
import '../../../domain/usecases/search_trip_use_case.dart';

part 'searching_for_driver_state.dart';

@Injectable()
class SearchingForDriverBloc extends Cubit<SearchingForDriverState> {
  final SocketService socketService;
  final CancelTripUseCase _cancelTripUseCase;
  final GetTripByIdUseCase getTripByIdUseCase;
  final GetTripByUUidUseCase getTripByUUidUseCase;
  final SearchTripUseCase searchTripUseCase;

  SearchingForDriverBloc(
    this._cancelTripUseCase,
    this.socketService,
    this.getTripByIdUseCase,
    this.searchTripUseCase,
    this.getTripByUUidUseCase,
  ) : super(SearchingForDriverInitial());

  void onInitializeSocket({
    required num tripId,
    required bool isCallSocket,
    required String uuid,
  }) async {
    try {
      if (isCallSocket) {
        emit(SearchForDriverLoading());
        final response = await searchTripUseCase(tripId: tripId);
        emit(
          response.fold(
            (l) => SearchForDriverFailure(msg: l.msg),
            (r) => SearchForDriverSuccess(),
          ),
        );
      }
      await socketService.ensureAuthorizedConnected();
      socketService.onEvent('trip-accepted', (data) async {
        final response = await getTripByUUidUseCase(uuid: data['tripId']);
        response.fold((l) {}, (r) => emit(DriverFound(tripModel: r.data)));
      });

      socketService.onEvent('trip-rejected', (data) {
        cancelTrip(tripId: tripId, uuid: uuid, cancelWithApi: false);
      });
    } catch (e) {
      emit(
        SocketError(
          errorMessage: 'Socket initialization failed: ${e.toString()}',
        ),
      );
    }
  }

  /// Cancel trip
  void cancelTrip({
    required num tripId,
    required String uuid,
    bool cancelWithApi = true,
  }) async {
    try {
      if (!cancelWithApi) {
        emit(CancelTripSuccess());
        return;
      }
      emit(CancelTripLoading());
      final response = await _cancelTripUseCase(id: tripId);
      response.fold(
        (failure) => emit(CancelTripFailure(errorMsg: failure.msg)),
        (success) {
          socketService.emitEvent("update-trip-status", {
            "tripId": uuid,
            "status": TripStatusEnum.cancelled.name,
          });
          emit(CancelTripSuccess());
        },
      );
    } catch (e) {
      Logger().e('Error canceling trip: $e');
      emit(
        CancelTripFailure(errorMsg: 'Failed to cancel trip: ${e.toString()}'),
      );
    }
  }
}
