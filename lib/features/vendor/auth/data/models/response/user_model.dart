import '../../../../../captain/app/data/models/generic_model.dart';

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.about,
    this.phone,
    this.email,
    this.province,
    this.region,
    this.address,
    this.lat,
    this.lng,
    this.logo,
    this.coverImage,
    this.deliveryPriceFrom,
    this.deliveryPriceTo,
    this.reviewsCount,
    this.reviewsAverage,
    this.commercialRegistration,
    this.profileImage,
    this.isAvailable,
    this.isProfileCompleted,
    this.status,
    this.preparationTime,
    this.deliveryTime,
    this.supplierCategories,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
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
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    logo = json['logo'];
    coverImage = json['cover_image'];
    deliveryPriceFrom = json['delivery_price_from'];
    deliveryPriceTo = json['delivery_price_to'];
    reviewsCount = json['reviews_count'];
    reviewsAverage = json['reviews_average'].toString();
    commercialRegistration = json['commercial_registration'];
    profileImage = json['profile_image'];
    isAvailable = json['is_available'];
    isProfileCompleted = json['is_profile_completed'];
    status = json['status'];
    preparationTime = json['preparation_time'];
    deliveryTime = json['delivery_time'];
    if (json['supplier_categories'] != null) {
      supplierCategories = [];
      json['supplier_categories'].forEach((element) {
        supplierCategories?.add(GenericModel.fromJson(element));
      });
    }
  }

  num? id;
  String? name;
  String? about;
  String? phone;
  String? email;
  GenericModel? province;
  GenericModel? region;
  String? address;
  String? lat;
  String? lng;
  String? logo;
  String? coverImage;
  num? deliveryPriceFrom;
  num? deliveryPriceTo;
  num? reviewsCount;
  String? reviewsAverage;
  String? commercialRegistration;
  String? profileImage;
  num? isAvailable;
  num? isProfileCompleted;
  String? status;
  String? preparationTime;
  String? deliveryTime;
  List<GenericModel>? supplierCategories;

  UserModel copyWith({
    num? id,
    String? name,
    String? about,
    String? phone,
    String? email,
    GenericModel? province,
    GenericModel? region,
    String? address,
    String? lat,
    String? lng,
    String? logo,
    String? coverImage,
    num? deliveryPriceFrom,
    num? deliveryPriceTo,
    num? reviewsCount,
    String? reviewsAverage,
    String? commercialRegistration,
    String? profileImage,
    num? isAvailable,
    num? isProfileCompleted,
    String? status,
    String? preparationTime,
    String? deliveryTime,
  }) => UserModel(
    id: id ?? this.id,
    name: name ?? this.name,
    about: about ?? this.about,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    province: province ?? this.province,
    region: region ?? this.region,
    address: address ?? this.address,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
    logo: logo ?? this.logo,
    coverImage: coverImage ?? this.coverImage,
    deliveryPriceFrom: deliveryPriceFrom ?? this.deliveryPriceFrom,
    deliveryPriceTo: deliveryPriceTo ?? this.deliveryPriceTo,
    reviewsCount: reviewsCount ?? this.reviewsCount,
    reviewsAverage: reviewsAverage ?? this.reviewsAverage,
    commercialRegistration:
        commercialRegistration ?? this.commercialRegistration,
    profileImage: profileImage ?? this.profileImage,
    isAvailable: isAvailable ?? this.isAvailable,
    isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
    status: status ?? this.status,
    preparationTime: preparationTime ?? this.preparationTime,
    deliveryTime: deliveryTime ?? this.deliveryTime,
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
    map['address'] = address;
    map['lat'] = lat;
    map['lng'] = lng;
    map['logo'] = logo;
    map['cover_image'] = coverImage;
    map['delivery_price_from'] = deliveryPriceFrom;
    map['delivery_price_to'] = deliveryPriceTo;
    map['reviews_count'] = reviewsCount;
    map['reviews_average'] = reviewsAverage;
    map['commercial_registration'] = commercialRegistration;
    map['profile_image'] = profileImage;
    map['is_available'] = isAvailable;
    map['is_profile_completed'] = isProfileCompleted;
    map['status'] = status;
    map['preparation_time'] = preparationTime;
    map['delivery_time'] = deliveryTime;
    return map;
  }
}
