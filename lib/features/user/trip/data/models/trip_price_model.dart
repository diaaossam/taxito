class TripPriceModel {
  TripPriceModel({
      this.vip, 
      this.normal,});

  TripPriceModel.fromJson(dynamic json) {
    vip = json['vip'] != null ? Vip.fromJson(json['vip']) : null;
    normal = json['normal'] != null ? Normal.fromJson(json['normal']) : null;
  }
  Vip? vip;
  Normal? normal;
TripPriceModel copyWith({  Vip? vip,
  Normal? normal,
}) => TripPriceModel(  vip: vip ?? this.vip,
  normal: normal ?? this.normal,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (vip != null) {
      map['vip'] = vip?.toJson();
    }
    if (normal != null) {
      map['normal'] = normal?.toJson();
    }
    return map;
  }

}

class Normal {
  Normal({
      this.kilometers, 
      this.price, 
      this.durationInMinutes,});

  Normal.fromJson(dynamic json) {
    kilometers = json['kilometers'];
    price = json['price'];
    durationInMinutes = json['duration_in_minutes'];
  }
  num? kilometers;
  num? price;
  num? durationInMinutes;
Normal copyWith({  num? kilometers,
  num? price,
  num? durationInMinutes,
}) => Normal(  kilometers: kilometers ?? this.kilometers,
  price: price ?? this.price,
  durationInMinutes: durationInMinutes ?? this.durationInMinutes,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kilometers'] = kilometers;
    map['price'] = price;
    map['duration_in_minutes'] = durationInMinutes;
    return map;
  }

}

class Vip {
  Vip({
      this.kilometers, 
      this.price, 
      this.durationInMinutes,});

  Vip.fromJson(dynamic json) {
    kilometers = json['kilometers'];
    price = json['price'];
    durationInMinutes = json['duration_in_minutes'];
  }
  num? kilometers;
  num? price;
  num? durationInMinutes;
Vip copyWith({  num? kilometers,
  num? price,
  num? durationInMinutes,
}) => Vip(  kilometers: kilometers ?? this.kilometers,
  price: price ?? this.price,
  durationInMinutes: durationInMinutes ?? this.durationInMinutes,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kilometers'] = kilometers;
    map['price'] = price;
    map['duration_in_minutes'] = durationInMinutes;
    return map;
  }

}