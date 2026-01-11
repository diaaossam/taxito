import 'package:injectable/injectable.dart';
import '../../../../../core/enum/trip_status_enum.dart';
import '../../../../../core/services/network/dio_consumer.dart';
import '../../../../../core/services/network/end_points.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../../../../core/utils/app_strings.dart';
import '../models/trip_model.dart';

abstract class DriverTripRemoteDataSource {
  Future<ApiSuccessResponse> getTripById({required num id});

  Future<ApiSuccessResponse> acceptTrip({required num tripId});

  Future<ApiSuccessResponse> rejectTrip({required num tripId});

  Future<ApiSuccessResponse> cancelTrip({required TripModel tripModel});

  Future<ApiSuccessResponse> getAllTrips({
    required String status,
    required int pageKey,
  });

  Future<ApiSuccessResponse> endTrip({required TripModel tripModel});

  Future<ApiSuccessResponse> acceptDriverPaymentRequest({
    required num id,
    required bool driverAcceptConfirmation,
  });

  Future<ApiSuccessResponse> updateStatus({
    required num id,
    required TripStatusEnum status,
  });

  Future<ApiSuccessResponse> getPendingTrips();
}

@Injectable(as: DriverTripRemoteDataSource)
class DriverTripRemoteDataSourceImpl implements DriverTripRemoteDataSource {
  final DioConsumer dioConsumer;

  DriverTripRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> getTripById({required num id}) async {
    final response = await dioConsumer.get(
      path: "${EndPoints.getTripById}/$id",
    );

    TripModel tripModel = TripModel.fromJson(response['data']);
    return ApiSuccessResponse(data: tripModel, response: response['data']);
  }

  @override
  Future<ApiSuccessResponse> acceptTrip({required num tripId}) async {
    final response = await dioConsumer.post(
      path: "${EndPoints.acceptTrip}/$tripId",
    );
    TripModel tripModel = TripModel.fromJson(response['data']);

    return ApiSuccessResponse(data: tripModel, response: response['data']);
  }

  @override
  Future<ApiSuccessResponse> cancelTrip({required TripModel tripModel}) async {
    final response = await dioConsumer.post(
      path: "${EndPoints.cancelTrip}/${tripModel.id}",
      body: {"cancel_trip_reason_id": 1},
    );
    return ApiSuccessResponse(message: response['message']);
  }

  @override
  Future<ApiSuccessResponse> getAllTrips({
    required String status,
    required int pageKey,
  }) async {
    final response = await dioConsumer.get(
      path: EndPoints.getTripById,
      params: {"status": status, "page": pageKey, "perPage": pageSize},
    );

    final List<TripModel> trips = response['data'].map<TripModel>((element) {
      return TripModel.fromJson(element);
    }).toList();

    return ApiSuccessResponse(data: trips);
  }

  @override
  Future<ApiSuccessResponse> endTrip({required TripModel tripModel}) async {
    final response = await dioConsumer.post(
      path: "${EndPoints.endTrip}/${tripModel.id}",
      body: {"cancel_trip_reason_id": 1},
    );
    return ApiSuccessResponse(
      data: TripModel.fromJson(response['data']),
      response: response['data'],
    );
  }

  @override
  Future<ApiSuccessResponse> acceptDriverPaymentRequest({
    required num id,
    required bool driverAcceptConfirmation,
  }) async {
    final response = await dioConsumer.post(
      path: "${EndPoints.driverAcceptPayment}$id",
      body: {"driver_accept_confirmation": driverAcceptConfirmation},
    );
    return ApiSuccessResponse(
      data: TripModel.fromJson(response['data']),
      response: response['data'],
    );
  }

  @override
  Future<ApiSuccessResponse> updateStatus({
    required num id,
    required TripStatusEnum status,
  }) async {
    final response = await dioConsumer.put(
      path: "${EndPoints.getTripById}/$id",
      body: {"status": status.name},
    );
    return ApiSuccessResponse(
      data: TripModel.fromJson(response['data']),
      response: response['data'],
    );
  }

  @override
  Future<ApiSuccessResponse> rejectTrip({required num tripId}) async {
    final _ = await dioConsumer.post(path: "${EndPoints.rejectTrip}/$tripId");

    return ApiSuccessResponse();
  }

  @override
  Future<ApiSuccessResponse> getPendingTrips() async {
    final response = await dioConsumer.get(path: EndPoints.pendingTrips);
    if (response['data'] is! List) {
      TripModel tripModel = TripModel.fromJson(response['data']['trip']);
      DateTime notifyAt = DateTime.parse(response['data']["notify_expired_at"]);
      DateTime notifyExpireAt = DateTime.parse(response['data']["server_time"]);
      final Duration difference = notifyAt.difference(notifyExpireAt);
      int? second;
      if (!difference.isNegative && difference.inSeconds < 30) {
        second = difference.inSeconds;
      }

      return ApiSuccessResponse(data: tripModel, response: {"second": second});
    }
    return ApiSuccessResponse();
  }
}
