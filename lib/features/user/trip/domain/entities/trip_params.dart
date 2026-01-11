import '../../../../../core/enum/payment_type.dart';

class TripParams {
  num? tripTypeId;
  String? fromAddress;
  num? fromLat;
  num? fromLng;
  String? toAddress;
  num? toLat;
  num? toLng;
  num? isSchedule;
  String? tripDate;
  String? tripTime;
  String? type;
  String? discountCode;
  String? priceCalculationType;
  PaymentType? paymentMethod;

  TripParams({
    this.tripTypeId,
    this.fromAddress,
    this.fromLat,
    this.fromLng,
    this.toAddress,
    this.toLat,
    this.toLng,
    this.tripDate,
    this.discountCode,
    this.tripTime,
    this.paymentMethod,
    this.type,
    this.isSchedule,
  });

  TripParams copyWith({
    num? tripTypeId,
    String? fromAddress,
    String? discountCode,
    num? fromLat,
    num? fromLng,
    String? toAddress,
    num? toLat,
    num? toLng,
    num? isSchedule,
    String? tripDate,
    String? tripTime,
    String? priceCalculationType,
    String? type,
    PaymentType? paymentMethod,
  }) => TripParams(
    paymentMethod: paymentMethod ?? this.paymentMethod,
    discountCode: discountCode ?? this.discountCode,
    tripTypeId: tripTypeId ?? this.tripTypeId,
    fromAddress: fromAddress ?? this.fromAddress,
    fromLat: fromLat ?? this.fromLat,
    fromLng: fromLng ?? this.fromLng,
    toAddress: toAddress ?? this.toAddress,
    isSchedule: isSchedule ?? this.isSchedule,
    toLat: toLat ?? this.toLat,
    type: type ?? this.type,
    toLng: toLng ?? this.toLng,
    tripDate: tripDate ?? this.tripDate,
    tripTime: tripTime ?? this.tripTime,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['trip_type_id'] = tripTypeId;
    map['address_from'] = fromAddress;
    map['discount_code'] = discountCode;
    map['address_from_latitude'] = fromLat;
    map['address_from_longitude'] = fromLng;
    map['address_to'] = toAddress;
    map['address_to_latitude'] = toLat;
    map['address_to_longitude'] = toLng;
    map['is_scheduled'] = isSchedule == 1 ? true : false;
    map['start_date'] = tripDate;
    map['start_time'] = tripTime;
    if (paymentMethod != null) map['payment_method'] = paymentMethod?.name;
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
