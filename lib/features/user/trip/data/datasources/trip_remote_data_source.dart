import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../../common/models/trip_model.dart';
import '../../../../../core/services/network/dio_consumer.dart';
import '../../../../../core/services/network/end_points.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../../../../core/utils/app_strings.dart';
import 'package:taxito/features/common/models/user_model.dart';
import '../../domain/entities/review_trip_params.dart';
import '../../domain/entities/trip_params.dart';

abstract class TripRemoteDataSource {
  Future<ApiSuccessResponse> requestTrip({required TripParams tripParams});

  Future<ApiSuccessResponse> cancelTrip({required num id});

  Future<ApiSuccessResponse> reportIssue({
    required String msg,
    required TripModel tripModel,
  });

  Future<ApiSuccessResponse> sendTripReview({
    required ReviewTripParams reviewParams,
  });

  Future<ApiSuccessResponse> sendPaymentUserRequest({
    required num id,
    required String paymentMethod,
  });

  Future<ApiSuccessResponse> validateCoupon({required String discountCode});

  Future<ApiSuccessResponse> getUserDriver({
    required LatLng lat,
    required double radius,
  });

  Future<ApiSuccessResponse> getTripByUuid({required String uuid});

  Future<ApiSuccessResponse> getTripById({required num id});

  Future<ApiSuccessResponse> getAllTrips({
    required String status,
    required int pageKey,
    required bool isSch,
  });

  Future<ApiSuccessResponse> searchTrip({required num tripId});
}

@Injectable(as: TripRemoteDataSource)
class TripRemoteDataSourceImpl implements TripRemoteDataSource {
  final DioConsumer dioConsumer;

  TripRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> requestTrip({
    required TripParams tripParams,
  }) async {
    final response = await dioConsumer.post(
      path: EndPoints.userTrips,
      body: tripParams.toJson(),
    );
    TripModel tripModel = TripModel.fromJson(response['data']);
    return ApiSuccessResponse(data: tripModel);
  }

  @override
  Future<ApiSuccessResponse> cancelTrip({required num id}) async {
    final response = await dioConsumer.post(
      path: EndPoints.cancelUserTrip(id),
      body: {"trip_cancel_reason_id": 1},
    );
    return ApiSuccessResponse();
  }

  @override
  Future<ApiSuccessResponse> reportIssue({
    required String msg,
    required TripModel tripModel,
  }) async {
    final response = await dioConsumer.post(
      path: "${EndPoints.sendProblem}/${tripModel.id}/problem",
      body: {"problem_description": msg},
    );
    return ApiSuccessResponse(message: response['message']);
  }

  @override
  Future<ApiSuccessResponse> sendTripReview({
    required ReviewTripParams reviewParams,
  }) async {
    final response = await dioConsumer.post(
      path: "${EndPoints.rateTrip}${reviewParams.tripId}/rate",
      body: reviewParams.toMap(),
    );
    return ApiSuccessResponse(message: response['message']);
  }

  @override
  Future<ApiSuccessResponse> sendPaymentUserRequest({
    required num id,
    required String paymentMethod,
  }) async {
    final response = await dioConsumer.post(
      path: "${EndPoints.sendPaymentRequestToDriver}/$id",
      body: {"payment_method": paymentMethod},
    );
    UserModel userModel = UserModel.fromJson(response['data']);
    return ApiSuccessResponse(data: userModel, response: response['data']);
  }

  @override
  Future<ApiSuccessResponse> validateCoupon({
    required String discountCode,
  }) async {
    final response = await dioConsumer.post(path: EndPoints.validateCoupon);
    return ApiSuccessResponse();
  }

  @override
  Future<ApiSuccessResponse> getUserDriver({
    required LatLng lat,
    required double radius,
  }) async {
    final response = await dioConsumer.post(
      path: EndPoints.userDrivers,
      body: {"lat": lat.latitude, "lng": lat.longitude, "radius": radius},
    );

    final List<UserModel> users = response['data']
        .map<UserModel>((element) => UserModel.fromJson(element))
        .toList();

    return ApiSuccessResponse(data: users);
  }

  @override
  Future<ApiSuccessResponse> getTripByUuid({required String uuid}) async {
    final response = await dioConsumer.get(
      path: "${EndPoints.getTripByUUid}/$uuid",
    );

    TripModel tripModel = TripModel.fromJson(response['data']);
    return ApiSuccessResponse(data: tripModel, response: response['data']);
  }

  @override
  Future<ApiSuccessResponse> getTripById({required num id}) async {
    final response = await dioConsumer.get(
      path: "${EndPoints.getTripUserById}/$id",
    );
    TripModel tripModel = TripModel.fromJson(response['data']);
    return ApiSuccessResponse(data: tripModel, response: response['data']);
  }

  @override
  Future<ApiSuccessResponse> getAllTrips({
    required String status,
    required int pageKey,
    required bool isSch,
  }) async {
    final response = await dioConsumer.get(
      path: EndPoints.getTrips,
      params: {
        "statuses[]": status,
        "page": pageKey,
        "perPage": pageSize,
        if (status == "pending") "is_scheduled": true,
      },
    );

    final List<TripModel> trips = response['data'].map<TripModel>((element) {
      return TripModel.fromJson(element);
    }).toList();

    return ApiSuccessResponse(data: trips);
  }

  @override
  Future<ApiSuccessResponse> searchTrip({required num tripId}) async {
    final response = await dioConsumer.get(
      path: "${EndPoints.searchForDriver}$tripId",
    );
    return ApiSuccessResponse();
  }
}
