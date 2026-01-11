import '../../../../../captain/app/data/models/generic_model.dart';

class MyAddress {
  MyAddress({
    this.id,
    this.province,
    this.region,
    this.name,
    this.lat,
    this.lng,
    this.address,
    this.notes,
    this.phone,
    this.isDefault,
    this.createdAt,
  });

  MyAddress.fromJson(dynamic json) {
    id = json['id'];
    province = json['province'] != null
        ? json['province'] is String
              ? GenericModel(id: 1, title: json['province'])
              : GenericModel.fromJson(json['province'])
        : null;
    region = json['region'] != null
        ? json['region'] is String
              ? GenericModel(id: 1, title: json['region'])
              : GenericModel.fromJson(json['region'])
        : null;
    name = json['name'];
    lat = json['latitude'].toString();
    lng = json['longitude'].toString();
    address = json['address'];
    notes = json['notes'];
    phone = json['phone'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
  }

  num? id;
  GenericModel? province;
  GenericModel? region;
  String? name;
  String? lat;
  String? lng;
  String? address;
  String? notes;
  String? phone;
  bool? isDefault;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (province != null) {
      map['province'] = province?.toMap();
    }
    if (region != null) {
      map['region'] = region?.toMap();
    }
    map['name'] = name;
    map['latitude'] = lat;
    map['longitude'] = lng;
    map['address'] = address;
    map['notes'] = notes;
    map['phone'] = phone;
    map['is_default'] = isDefault;
    map['created_at'] = createdAt;
    return map;
  }
}
