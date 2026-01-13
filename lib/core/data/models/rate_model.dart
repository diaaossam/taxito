class RateModel {
  RateModel({
      this.id, 
      this.driverId, 
      this.tripId, 
      this.userId, 
      this.rate, 
      this.comment, 
      this.createdAt, 
      this.updatedAt,});

  RateModel.fromJson(dynamic json) {
    id = json['id'];
    driverId = json['driver_id'];
    tripId = json['trip_id'];
    userId = json['user_id'];
    rate = json['rate'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? driverId;
  num? tripId;
  num? userId;
  num? rate;
  String? comment;
  String? createdAt;
  String? updatedAt;
RateModel copyWith({  num? id,
  num? driverId,
  num? tripId,
  num? userId,
  num? rate,
  String? comment,
  String? createdAt,
  String? updatedAt,
}) => RateModel(  id: id ?? this.id,
  driverId: driverId ?? this.driverId,
  tripId: tripId ?? this.tripId,
  userId: userId ?? this.userId,
  rate: rate ?? this.rate,
  comment: comment ?? this.comment,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['driver_id'] = driverId;
    map['trip_id'] = tripId;
    map['user_id'] = userId;
    map['rate'] = rate;
    map['comment'] = comment;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}