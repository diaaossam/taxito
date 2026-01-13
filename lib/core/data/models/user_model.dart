import 'package:taxito/core/data/models/trip_model.dart';
import 'package:taxito/core/enum/choose_enum.dart';
import 'package:taxito/core/enum/gender.dart';
import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/features/captain/app/data/models/generic_model.dart';
import 'package:taxito/features/captain/delivery_order/data/models/response/my_address.dart';

class UserModel {
  UserModel({
    // Common fields
    this.id,
    this.name,
    this.phone,
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.status,
    this.isProfileCompleted,
    this.address,
    this.defaultLang,
    this.createdAt,
    this.updatedAt,
    this.userType,

    // User-specific fields
    this.jobTitle,
    this.gender,
    this.image,
    this.carPlateNumber,
    this.currentAddress,
    this.logo,
    this.userTripModel,
    this.points,
    this.code,
    this.latitude,
    this.longitude,

    // Vendor-specific fields
    this.about,
    this.province,
    this.region,
    this.lat,
    this.lng,
    this.coverImage,
    this.deliveryPriceFrom,
    this.deliveryPriceTo,
    this.reviewsCount,
    this.reviewsAverage,
    this.commercialRegistration,
    this.isAvailable,
    this.preparationTime,
    this.deliveryTime,
    this.supplierCategories,

    // Captain-specific fields
    this.driverType,
    this.vehicleType,
    this.idFrontImage,
    this.idBackImage,
    this.driverLicenseFrontImage,
    this.driverLicenseBackImage,
    this.cars,
    this.carInsuranceFrontImage,
    this.carInsuranceBackImage,
    this.isAvailableEnum,
    this.enableNotifications,
    this.captainTripModel,
  });

  UserModel.fromJson(dynamic json) {
    // Common fields
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['profile_image'] ?? json['image'] ?? json['logo'];
    status = json['status'];
    isProfileCompleted = json['is_profile_completed'];
    address = json['address'] ?? "";
    defaultLang = json['default_lang'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userType = handleUserType(userType: json['account_type']);

    // User-specific fields
    jobTitle = json['job_title'];
    gender = json['gender'] != null ? handleGender(json['gender']) : null;
    image = json['image'];
    carPlateNumber = json['car_plate_number'];
    currentAddress = json['current_address'] != null
        ? MyAddress.fromJson(json['current_address'])
        : null;
    logo = json['logo'];
    userTripModel = json['trip'] != null
        ? TripModel.fromJson(json['trip'])
        : null;
    points = json['points']?.toString();
    code = json['point_code'];
    latitude = json['latitude'] != null
        ? (json['latitude'] is String
              ? json['latitude']
              : json['latitude'].toString())
        : null;
    longitude = json['longitude'] != null
        ? (json['longitude'] is String
              ? json['longitude']
              : json['longitude'].toString())
        : null;

    // Vendor-specific fields
    about = json['about'];
    province = json['province'] != null
        ? GenericModel.fromJson(json['province'])
        : null;
    region = json['region'] != null
        ? GenericModel.fromJson(json['region'])
        : null;
    lat = json['lat'];
    lng = json['lng'];
    coverImage = json['cover_image'];
    deliveryPriceFrom = json['delivery_price_from'];
    deliveryPriceTo = json['delivery_price_to'];
    reviewsCount = json['reviews_count'];
    reviewsAverage = json['reviews_average']?.toString();
    commercialRegistration = json['commercial_registration'];
    isAvailable = json['is_available'];
    preparationTime = json['preparation_time'];
    deliveryTime = json['delivery_time'];
    if (json['supplier_categories'] != null) {
      supplierCategories = [];
      json['supplier_categories'].forEach((element) {
        supplierCategories?.add(GenericModel.fromJson(element));
      });
    }

    // Captain-specific fields
    driverType = json['driver_type'];
    vehicleType = json['vehicle_type'];
    idFrontImage = json['id_front_image'];
    idBackImage = json['id_back_image'];
    driverLicenseFrontImage = json['driver_license_front_image'];
    driverLicenseBackImage = json['driver_license_back_image'];
    if (json['cars'] != null) {
      cars = [];
      json['cars'].forEach((v) {
        cars?.add(Cars.fromJson(v));
      });
    }
    carInsuranceFrontImage = json['car_insurance_front_image'];
    carInsuranceBackImage = json['car_insurance_back_image'];
    isAvailableEnum = json['is_available'] == 1
        ? ChooseEnum.yes
        : ChooseEnum.no;
    enableNotifications = json['enable_notifications'];
    captainTripModel = json['trip'] != null
        ? TripModel.fromJson(json['trip'])
        : null;
  }

  // Common fields
  num? id;
  String? name;
  String? phone;
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? status;
  num? isProfileCompleted;
  String? address;
  String? defaultLang;
  String? createdAt;
  String? updatedAt;
  UserType? userType;

  // User-specific fields
  String? jobTitle;
  Gender? gender;
  String? image;
  String? carPlateNumber;
  MyAddress? currentAddress;
  String? logo;
  TripModel? userTripModel;
  String? points;
  String? code;
  String? latitude;
  String? longitude;

  // Vendor-specific fields
  String? about;
  GenericModel? province;
  GenericModel? region;
  String? lat;
  String? lng;
  String? coverImage;
  num? deliveryPriceFrom;
  num? deliveryPriceTo;
  num? reviewsCount;
  String? reviewsAverage;
  String? commercialRegistration;
  num? isAvailable;
  String? preparationTime;
  String? deliveryTime;
  List<GenericModel>? supplierCategories;

  // Captain-specific fields
  String? driverType;
  String? vehicleType;
  String? idFrontImage;
  String? idBackImage;
  String? driverLicenseFrontImage;
  String? driverLicenseBackImage;
  List<Cars>? cars;
  String? carInsuranceFrontImage;
  String? carInsuranceBackImage;
  ChooseEnum? isAvailableEnum;
  num? enableNotifications;
  TripModel? captainTripModel;

  // Convenience getter for trip model
  dynamic get tripModel => captainTripModel ?? userTripModel;

  UserModel copyWith({
    num? id,
    String? name,
    String? phone,
    String? email,
    String? firstName,
    String? lastName,
    String? profileImage,
    String? status,
    num? isProfileCompleted,
    String? address,
    String? defaultLang,
    String? createdAt,
    String? updatedAt,
    String? jobTitle,
    Gender? gender,
    String? image,
    String? carPlateNumber,
    MyAddress? currentAddress,
    String? logo,
    TripModel? userTripModel,
    String? points,
    String? code,
    String? latitude,
    String? longitude,
    String? about,
    GenericModel? province,
    GenericModel? region,
    String? lat,
    String? lng,
    String? coverImage,
    num? deliveryPriceFrom,
    num? deliveryPriceTo,
    num? reviewsCount,
    String? reviewsAverage,
    String? commercialRegistration,
    num? isAvailable,
    String? preparationTime,
    String? deliveryTime,
    List<GenericModel>? supplierCategories,
    String? driverType,
    String? vehicleType,
    String? idFrontImage,
    String? idBackImage,
    String? driverLicenseFrontImage,
    String? driverLicenseBackImage,
    List<Cars>? cars,
    String? carInsuranceFrontImage,
    String? carInsuranceBackImage,
    ChooseEnum? isAvailableEnum,
    num? enableNotifications,
    TripModel? captainTripModel,
  }) => UserModel(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    profileImage: profileImage ?? this.profileImage,
    status: status ?? this.status,
    isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
    address: address ?? this.address,
    defaultLang: defaultLang ?? this.defaultLang,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    jobTitle: jobTitle ?? this.jobTitle,
    gender: gender ?? this.gender,
    image: image ?? this.image,
    carPlateNumber: carPlateNumber ?? this.carPlateNumber,
    currentAddress: currentAddress ?? this.currentAddress,
    logo: logo ?? this.logo,
    userTripModel: userTripModel ?? this.userTripModel,
    points: points ?? this.points,
    code: code ?? this.code,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    about: about ?? this.about,
    province: province ?? this.province,
    region: region ?? this.region,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
    coverImage: coverImage ?? this.coverImage,
    deliveryPriceFrom: deliveryPriceFrom ?? this.deliveryPriceFrom,
    deliveryPriceTo: deliveryPriceTo ?? this.deliveryPriceTo,
    reviewsCount: reviewsCount ?? this.reviewsCount,
    reviewsAverage: reviewsAverage ?? this.reviewsAverage,
    commercialRegistration:
        commercialRegistration ?? this.commercialRegistration,
    isAvailable: isAvailable ?? this.isAvailable,
    preparationTime: preparationTime ?? this.preparationTime,
    deliveryTime: deliveryTime ?? this.deliveryTime,
    supplierCategories: supplierCategories ?? this.supplierCategories,
    driverType: driverType ?? this.driverType,
    vehicleType: vehicleType ?? this.vehicleType,
    idFrontImage: idFrontImage ?? this.idFrontImage,
    idBackImage: idBackImage ?? this.idBackImage,
    driverLicenseFrontImage:
        driverLicenseFrontImage ?? this.driverLicenseFrontImage,
    driverLicenseBackImage:
        driverLicenseBackImage ?? this.driverLicenseBackImage,
    cars: cars ?? this.cars,
    carInsuranceFrontImage:
        carInsuranceFrontImage ?? this.carInsuranceFrontImage,
    carInsuranceBackImage: carInsuranceBackImage ?? this.carInsuranceBackImage,
    isAvailableEnum: isAvailableEnum ?? this.isAvailableEnum,
    enableNotifications: enableNotifications ?? this.enableNotifications,
    captainTripModel: captainTripModel ?? this.captainTripModel,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    // Common fields
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['profile_image'] = profileImage;
    map['status'] = status;
    map['is_profile_completed'] = isProfileCompleted;
    map['address'] = address;
    map['default_lang'] = defaultLang;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;

    // User-specific fields
    map['job_title'] = jobTitle;
    map['gender'] = gender;
    map['image'] = image;
    map['car_plate_number'] = carPlateNumber;
    if (currentAddress != null) {
      map['current_address'] = currentAddress?.toJson();
    }
    map['logo'] = logo;
    map['points'] = points;
    map['point_code'] = code;
    map['latitude'] = latitude;
    map['longitude'] = longitude;

    // Vendor-specific fields
    map['about'] = about;
    if (province != null) {
      map['province'] = province?.toMap();
    }
    if (region != null) {
      map['region'] = region?.toMap();
    }
    map['lat'] = lat;
    map['lng'] = lng;
    map['cover_image'] = coverImage;
    map['delivery_price_from'] = deliveryPriceFrom;
    map['delivery_price_to'] = deliveryPriceTo;
    map['reviews_count'] = reviewsCount;
    map['reviews_average'] = reviewsAverage;
    map['commercial_registration'] = commercialRegistration;
    map['is_available'] = isAvailable;
    map['preparation_time'] = preparationTime;
    map['delivery_time'] = deliveryTime;
    if (supplierCategories != null) {
      map['supplier_categories'] = supplierCategories
          ?.map((e) => e.toMap())
          .toList();
    }

    // Captain-specific fields
    map['driver_type'] = driverType;
    map['vehicle_type'] = vehicleType;
    map['id_front_image'] = idFrontImage;
    map['id_back_image'] = idBackImage;
    map['driver_license_front_image'] = driverLicenseFrontImage;
    map['driver_license_back_image'] = driverLicenseBackImage;
    if (cars != null) {
      map['cars'] = cars?.map((e) => e.toJson()).toList();
    }
    map['car_insurance_front_image'] = carInsuranceFrontImage;
    map['car_insurance_back_image'] = carInsuranceBackImage;
    map['enable_notifications'] = enableNotifications;

    return map;
  }
}

class Cars {
  Cars({this.id, this.url});

  Cars.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
  }

  String? id;
  String? url;

  Cars copyWith({String? id, String? url}) =>
      Cars(id: id ?? this.id, url: url ?? this.url);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    return map;
  }
}
