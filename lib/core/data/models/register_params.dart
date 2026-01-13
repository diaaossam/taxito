import 'package:taxito/core/enum/user_type.dart';

class RegisterParams {
  // Common fields
  final String? name;
  final String? email;
  final String? phone;
  final String? profileImage;

  // User-specific fields
  final String? gender;
  final String? jobTitle;
  final String? imagePath;

  // Vendor-specific fields
  final String? about;
  final List<int>? supplierCategories;
  final String? provinceId;
  final String? regionId;
  final String? commercialRegistration;
  final String? logo;
  final String? foodPreparationTime;
  final String? deliveryTime;
  final String? coverImage;
  final String? address;
  final num? lat;
  final num? lon;

  // Captain-specific fields
  final String? userType;
  final String? carPlateNumber;
  final String? uid;
  final bool? isUpdate;
  final String? accountType;
  final String? firstName;
  final String? lastName;
  final int? governorateId;
  final String? frontIdImage;
  final String? backIdImage;
  final String? frontDriverLicense;
  final String? backDriverLicense;
  final List<String>? carImages;
  final String? frontInsurancePhoto;
  final String? backInsurancePhoto;
  final UserType? userTypeEnum;

  RegisterParams({
    // Common fields
    this.name,
    this.email,
    this.phone,
    this.profileImage,

    // User-specific fields
    this.gender,
    this.jobTitle,
    this.imagePath,

    // Vendor-specific fields
    this.about,
    this.supplierCategories,
    this.provinceId,
    this.regionId,
    this.commercialRegistration,
    this.logo,
    this.foodPreparationTime,
    this.deliveryTime,
    this.coverImage,
    this.address,
    this.lat,
    this.lon,

    // Captain-specific fields
    this.userType,
    this.carPlateNumber,
    this.uid,
    this.isUpdate,
    this.accountType,
    this.firstName,
    this.lastName,
    this.governorateId,
    this.frontIdImage,
    this.backIdImage,
    this.frontDriverLicense,
    this.backDriverLicense,
    this.carImages,
    this.frontInsurancePhoto,
    this.backInsurancePhoto,
    this.userTypeEnum,
  });

  factory RegisterParams.fromJson(Map<String, dynamic> json) {
    return RegisterParams(
      // Common fields
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profileImage: json['profile_image'] as String?,

      // User-specific fields
      gender: json['gender'] as String?,
      jobTitle: json['job_title'] as String?,

      // Vendor-specific fields
      about: json['about'] as String?,
      supplierCategories: (json['supplier_categories'] as List?)
          ?.map((e) => e as int)
          .toList(),
      provinceId: json['province_id'] as String?,
      regionId: json['region_id'] as String?,
      commercialRegistration: json['commercial_registration'] as String?,
      logo: json['logo'] as String?,
      foodPreparationTime: json['food_preparation_time'] as String?,
      deliveryTime: json['delivery_time'] as String?,
      coverImage: json['cover_image'] as String?,
      address: json['address'] as String?,
      lat: json['lat'] as num?,
      lon: json['lng'] as num?,

      // Captain-specific fields
      userType: json['user_type'] as String?,
      carPlateNumber: json['car_plate_number'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      governorateId: json['province_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};

    // Common fields
    if (name != null) map['name'] = name;
    if (email != null) map['email'] = email;
    if (phone != null) map['phone'] = phone;

    // User-specific fields
    if (gender != null) map['gender'] = gender;
    if (jobTitle != null) map['job_title'] = jobTitle;

    // Vendor-specific fields
    if (about != null) map['about'] = about;
    if (supplierCategories != null) {
      for (var i = 0; i < supplierCategories!.length; i++) {
        map['supplier_categories[$i]'] = supplierCategories![i];
      }
    }
    if (provinceId != null) map['province_id'] = provinceId;
    if (regionId != null) map['region_id'] = regionId;
    if (logo != null) map['logo'] = logo;
    if (foodPreparationTime != null)
      map['preparation_time'] = foodPreparationTime;
    if (deliveryTime != null) map['delivery_time'] = deliveryTime;
    if (lat != null) map['lat'] = lat;
    if (lon != null) map['lng'] = lon;
    if (address != null) map['address'] = address;

    // Captain-specific fields
    if (firstName != null) map['first_name'] = firstName;
    if (lastName != null) map['last_name'] = lastName;
    if (userType != null) map['user_type'] = userType;
    if (carPlateNumber != null) map['car_plate_number'] = carPlateNumber;
    if (governorateId != null) map['province_id'] = governorateId;

    // Remove null values
    map.removeWhere((key, value) => value == null);

    return map;
  }

  RegisterParams copyWith({
    // Common fields
    String? name,
    String? email,
    String? phone,
    String? profileImage,

    // User-specific fields
    String? gender,
    String? jobTitle,
    String? imagePath,

    // Vendor-specific fields
    String? about,
    List<int>? supplierCategories,
    String? provinceId,
    String? regionId,
    String? commercialRegistration,
    String? logo,
    String? foodPreparationTime,
    String? deliveryTime,
    String? coverImage,
    String? address,
    num? lat,
    num? lon,

    // Captain-specific fields
    String? userType,
    String? carPlateNumber,
    String? uid,
    bool? isUpdate,
    String? accountType,
    String? firstName,
    String? lastName,
    int? governorateId,
    String? frontIdImage,
    String? backIdImage,
    String? frontDriverLicense,
    String? backDriverLicense,
    List<String>? carImages,
    String? frontInsurancePhoto,
    String? backInsurancePhoto,
    UserType? userTypeEnum,
  }) {
    return RegisterParams(
      // Common fields
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,

      // User-specific fields
      gender: gender ?? this.gender,
      jobTitle: jobTitle ?? this.jobTitle,
      imagePath: imagePath ?? this.imagePath,

      // Vendor-specific fields
      about: about ?? this.about,
      supplierCategories: supplierCategories ?? this.supplierCategories,
      provinceId: provinceId ?? this.provinceId,
      regionId: regionId ?? this.regionId,
      commercialRegistration:
          commercialRegistration ?? this.commercialRegistration,
      logo: logo ?? this.logo,
      foodPreparationTime: foodPreparationTime ?? this.foodPreparationTime,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      coverImage: coverImage ?? this.coverImage,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,

      // Captain-specific fields
      userType: userType ?? this.userType,
      carPlateNumber: carPlateNumber ?? this.carPlateNumber,
      uid: uid ?? this.uid,
      isUpdate: isUpdate ?? this.isUpdate,
      accountType: accountType ?? this.accountType,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      governorateId: governorateId ?? this.governorateId,
      frontIdImage: frontIdImage ?? this.frontIdImage,
      backIdImage: backIdImage ?? this.backIdImage,
      frontDriverLicense: frontDriverLicense ?? this.frontDriverLicense,
      backDriverLicense: backDriverLicense ?? this.backDriverLicense,
      carImages: carImages ?? this.carImages,
      frontInsurancePhoto: frontInsurancePhoto ?? this.frontInsurancePhoto,
      backInsurancePhoto: backInsurancePhoto ?? this.backInsurancePhoto,
      userTypeEnum: userTypeEnum ?? this.userTypeEnum,
    );
  }
}
