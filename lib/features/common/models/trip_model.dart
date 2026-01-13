import 'package:taxito/features/common/models/rate_model.dart';
import 'package:taxito/features/common/models/user_model.dart';

import '../../captain/app/data/models/generic_model.dart';
import '../../../core/enum/payment_type.dart';
import '../../../core/enum/trip_status_enum.dart';
import 'main_location_data.dart';

class TripModel {
  TripModel({
    this.id,
    this.uuid,
    this.tripCode,
    this.startDate,
    this.startTime,
    this.from,
    this.to,
    this.tripType,
    this.driver,
    this.user,
    this.distance,
    this.distanceOfDriver,
    this.duration,
    this.totalPrice,
    this.status,
    this.paymentStatus,
    this.paymentMethod,
    this.cancelReason,
    this.canceledBy,
    this.tripCancelReason,
    this.cancelledAt,
    this.acceptedAt,
    this.driverStartedAt,
    this.driverArrivedAt,
    this.startedAt,
    this.completedAt,
    this.rate,
    this.hasProblem,
    this.problemDescription,
    this.createdAt,
    this.updatedAt,
    this.chatId,
    this.driverAcceptConfirmation,
    this.userSentRequestConfirmPayment,
    this.priceCalculationType,
    this.isSchedule,
    this.remainingPrice,
  });

  factory TripModel.fromJson(dynamic json) {
    return TripModel(
      id: json['id'],
      uuid: json['uuid'],
      tripCode: json['trip_code'] is num
          ? json['trip_code']
          : num.tryParse(json['trip_code']?.toString() ?? ''),
      startDate: json['start_date'],
      startTime: json['start_time'],
      from: json['from'] != null
          ? MainLocationData.fromJson(json['from'])
          : null,
      to: json['to'] != null ? MainLocationData.fromJson(json['to']) : null,
      tripType: json['trip_type'] != null
          ? GenericModel.fromJson(json['trip_type'])
          : null,
      driver: json['driver'] != null
          ? UserModel.fromJson(json['driver'])
          : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      rate: json['rate'] != null ? RateModel.fromJson(json['rate']) : null,
      distance: json['distance'],
      distanceOfDriver: json['distance_of_driver'],
      duration: json['duration'],
      totalPrice: json['total_price'],
      chatId: json['chat_id'] != null
          ? ChatId.fromJson(json: json['chat_id'])
          : null,
      status: json['status'] != null
          ? handleStringToTripStatusEnum(data: json['status'])
          : null,
      paymentStatus: json['payment_status'],
      paymentMethod: json['payment_method'] != null
          ? handleStringToPayment(payment: json['payment_method'])
          : null,
      cancelReason: json['cancel_reason'] != null
          ? GenericModel.fromJson(json['cancel_reason'])
          : null,
      canceledBy: json['canceled_by'],
      tripCancelReason: json['trip_cancel_reason'] != null
          ? GenericModel.fromJson(json['trip_cancel_reason'])
          : null,
      cancelledAt: json['cancelled_at'] != null
          ? DateTime.parse(json['cancelled_at'])
          : null,
      acceptedAt: json['accepted_at'] != null
          ? DateTime.parse(json['accepted_at'])
          : null,
      driverStartedAt: json['driver_started_at'] != null
          ? DateTime.parse(json['driver_started_at'])
          : null,
      driverArrivedAt: json['driver_arrived_at'] != null
          ? DateTime.parse(json['driver_arrived_at'])
          : null,
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'])
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      hasProblem: json['has_problem'],
      problemDescription: json['problem_description'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      remainingPrice: json['remaining_price'],
      isSchedule: json['is_scheduled'] ?? json['is_schedule'],
      userSentRequestConfirmPayment: json['user_sent_request_confirm_payment'],
      driverAcceptConfirmation: json['driver_accept_confirmation'],
      priceCalculationType: json['price_calculation_type'],
    );
  }

  num? id;
  String? uuid;
  num? tripCode;
  String? startDate;
  String? startTime;
  MainLocationData? from;
  MainLocationData? to;
  GenericModel? tripType;
  UserModel? driver;
  UserModel? user;
  num? distance;
  num? distanceOfDriver;
  num? duration;
  num? totalPrice;
  TripStatusEnum? status;
  String? paymentStatus;
  PaymentType? paymentMethod;
  ChatId? chatId;
  GenericModel? cancelReason;
  String? canceledBy;
  GenericModel? tripCancelReason;
  DateTime? cancelledAt;
  DateTime? acceptedAt;
  DateTime? driverStartedAt;
  DateTime? driverArrivedAt;
  DateTime? startedAt;
  DateTime? completedAt;
  RateModel? rate;
  bool? hasProblem;
  dynamic problemDescription;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? remainingPrice;
  num? isSchedule;
  num? userSentRequestConfirmPayment;
  num? driverAcceptConfirmation;
  String? priceCalculationType;
}

class ChatId {
  final num? id;
  final String? uuid;

  ChatId({this.id, this.uuid});

  factory ChatId.fromJson({required dynamic json}) {
    return ChatId(id: json['id'], uuid: json['uuid']);
  }
}

extension TripModelCopyWith on TripModel {
  TripModel copyWith({
    TripStatusEnum? status,
    num? totalPrice,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    bool? hasProblem,
  }) {
    return TripModel(
      id: id,
      uuid: uuid,
      tripCode: tripCode,
      startDate: startDate,
      startTime: startTime,
      from: from,
      to: to,
      tripType: tripType,
      driver: driver,
      user: user,
      distance: distance,
      distanceOfDriver: distanceOfDriver,
      duration: duration,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      paymentStatus: paymentStatus,
      paymentMethod: paymentMethod,
      cancelReason: cancelReason,
      canceledBy: canceledBy,
      tripCancelReason: tripCancelReason,
      cancelledAt: cancelledAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      driverStartedAt: driverStartedAt,
      driverArrivedAt: driverArrivedAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      rate: rate,
      hasProblem: hasProblem ?? this.hasProblem,
      problemDescription: problemDescription,
      createdAt: createdAt,
      updatedAt: updatedAt,
      chatId: chatId,
      driverAcceptConfirmation: driverAcceptConfirmation,
      userSentRequestConfirmPayment: userSentRequestConfirmPayment,
      priceCalculationType: priceCalculationType,
      isSchedule: isSchedule,
      remainingPrice: remainingPrice,
    );
  }
}
