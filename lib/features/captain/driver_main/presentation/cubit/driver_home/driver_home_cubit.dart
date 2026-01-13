import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import '../../../../../common/models/trip_model.dart';
import '../../../../../../core/enum/choose_enum.dart';
import '../../../../../../core/services/socket/socket.dart';
import 'package:taxito/features/common/models/user_model.dart';
import '../../../../driver_trip/domain/usecases/get_trip_by_id_use_case.dart';
import '../../../../driver_trip/domain/usecases/pending_trips_use_case.dart';

part 'driver_home_state.dart';

@Injectable()
class DriverHomeCubit extends Cubit<DriverHomeState> {
  final GetTripByIdUseCase getTripByIdUseCase;
  final PendingTripsUseCase pendingTripsUseCase;
  final SocketService socketService;
  TripModel? tripModel;
  Map<String, dynamic> tripMap = {};

  DriverHomeCubit(
    this.socketService,
    this.getTripByIdUseCase,
    this.pendingTripsUseCase,
  ) : super(DriverHomeInitial());

  bool _isHandlingTrip = false;
  final Set<num> _recentTripIds = {};

  Future<void> listenToTripsRequests({required ChooseEnum isAvailable}) async {
    if (isAvailable == ChooseEnum.yes) {
      socketService.onEvent("new-trip", (data) async {
        Logger().w("-------=-=${data}");

        if (_isHandlingTrip) return;
        _isHandlingTrip = true;

        try {
          final tripModel = TripModel.fromJson(data);
          final tripId = tripModel.id;
          if (_recentTripIds.contains(tripId)) {
            print("⚠️ Duplicate trip ignored: $tripId");
            return;
          }
          _recentTripIds.add(tripId!);
          Future.delayed(const Duration(seconds: 3), () {
            _recentTripIds.remove(tripId);
          });

          if (!isClosed) {
            print("🚗 New Trip Received: $tripId");
            emit(ReceiveTripRequestState(tripModel: tripModel));
          }
        } catch (e, s) {
          print("❌ Error handling trip socket: $e\n$s");
        } finally {
          _isHandlingTrip = false;
        }
      });
    }
  }

  Future<void> getTripModelByUuid({required num id}) async {
    emit(GetTripByUuidLoading());
    final response = await getTripByIdUseCase(id: id);
    emit(
      response.fold((l) => GetTripByUuidFailure(errorMsg: l.msg), (r) {
        tripModel = r.data;
        tripMap = r.response ?? {};
        return GetTripByUuidSuccess(tripModel: r.data);
      }),
    );
  }

  int second = 45;

  Future<void> initTrip({TripModel? model, UserModel? userModel}) async {
    if (userModel != null) {
      if (userModel.tripModel != null) {
        tripModel = userModel.tripModel;
      }
    } else if (model != null) {
      tripModel = model;
      emit(InitTripState(tripModel: model, second: 60));
    } else {
      final response = await pendingTripsUseCase();
      response.fold(
        (l) {
          Logger().e("Error fetching pending trips: ${l.msg}");
        },
        (r) {
          if (r.data != null) {
            tripModel = r.data;

            int second =
                (r.response != null
                    ? int.tryParse(r.response!['second'].toString())
                    : null) ??
                0;
            if (second != 0) {
              this.second = second;
              emit(InitTripState(tripModel: tripModel, second: second));
            }
          }
        },
      );
    }
  }
}
