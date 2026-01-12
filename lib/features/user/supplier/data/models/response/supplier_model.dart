import 'dart:math';

import '../../../../../captain/app/data/models/generic_model.dart';

class SupplierModel {
  SupplierModel({
    this.id,
    this.name,
    this.about,
    this.phone,
    this.email,
    this.province,
    this.region,
    this.logo,
    this.coverImage,
    this.deliveryPriceFrom,
    this.deliveryPriceTo,
    this.reviewsCount,
    this.reviewsAverage,
    this.distance,
    this.duration,
    this.isAddedToFavourite,
  });

  SupplierModel.fromJson(dynamic json) {
    id = json['id'] is String ? Random().nextInt(2002000) : json['id'];
    name = json['name'];
    about = json['about'];
    phone = json['phone'];
    email = json['email'];
    province = json['province'] != null
        ? GenericModel.fromJson(json['province'])
        : null;
    region = json['region'] != null
        ? GenericModel.fromJson(json['region'])
        : null;
    logo = json['logo'];
    coverImage = json['cover_image'];
    deliveryPriceFrom = json['delivery_price_from'];
    deliveryPriceTo = json['delivery_price_to'];
    reviewsCount = json['reviews_count'];
    reviewsAverage = json['reviews_average'].toString();
    distance = json['distance'];
    duration = json['duration'];
    isAddedToFavourite = json['is_added_to_favourite'];
  }

  num? id;
  String? name;
  String? about;
  String? phone;
  String? email;
  GenericModel? province;
  GenericModel? region;
  String? logo;
  String? coverImage;
  num? deliveryPriceFrom;
  num? deliveryPriceTo;
  num? reviewsCount;
  String? reviewsAverage;
  num? distance;
  num? duration;
  bool? isAddedToFavourite;

  SupplierModel copyWith({
    num? id,
    String? name,
    String? about,
    String? phone,
    String? email,
    GenericModel? province,
    GenericModel? region,
    String? logo,
    String? coverImage,
    num? deliveryPriceFrom,
    num? deliveryPriceTo,
    num? reviewsCount,
    String? reviewsAverage,
    num? distance,
    num? duration,
    bool? isAddedToFavourite,
  }) => SupplierModel(
    id: id ?? this.id,
    name: name ?? this.name,
    about: about ?? this.about,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    province: province ?? this.province,
    region: region ?? this.region,
    logo: logo ?? this.logo,
    coverImage: coverImage ?? this.coverImage,
    deliveryPriceFrom: deliveryPriceFrom ?? this.deliveryPriceFrom,
    deliveryPriceTo: deliveryPriceTo ?? this.deliveryPriceTo,
    reviewsCount: reviewsCount ?? this.reviewsCount,
    reviewsAverage: reviewsAverage ?? this.reviewsAverage,
    distance: distance ?? this.distance,
    duration: duration ?? this.duration,
    isAddedToFavourite: isAddedToFavourite ?? this.isAddedToFavourite,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['about'] = about;
    map['phone'] = phone;
    map['email'] = email;
    if (province != null) {
      map['province'] = province?.toMap();
    }
    if (region != null) {
      map['region'] = region?.toMap();
    }
    map['logo'] = logo;
    map['cover_image'] = coverImage;
    map['delivery_price_from'] = deliveryPriceFrom;
    map['delivery_price_to'] = deliveryPriceTo;
    map['reviews_count'] = reviewsCount;
    map['reviews_average'] = reviewsAverage;
    map['distance'] = distance;
    map['duration'] = duration;
    map['is_added_to_favourite'] = isAddedToFavourite;
    return map;
  }
}
