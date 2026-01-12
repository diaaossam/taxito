import 'package:taxito/features/user/trip/data/models/trip_model.dart';
import '../../../../../../core/enum/gender.dart';
import '../../../../../captain/delivery_order/data/models/response/my_address.dart';

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.jobTitle,
    this.gender,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.defaultLang,
    this.carPlateNumber,
    this.image,
    this.isProfileCompleted,
    this.currentAddress,
    this.status,
    this.createdAt,
    this.logo,
    this.tripModel,
    this.points,
    this.code,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    carPlateNumber = json['car_plate_number'];
    profileImage = json['profile_image'] ?? json['image'];
    jobTitle = json['job_title'];
    gender = json['gender'] != null ? handleGender(json['gender']) : null;
    defaultLang = json['default_lang'];
    image = json['image'];
    logo = json['logo'];
    carPlateNumber = json['car_plate_number'];
    isProfileCompleted = json['is_profile_completed'];
    currentAddress = json['current_address'] != null
        ? MyAddress.fromJson(json['current_address'])
        : null;
    tripModel = json['trip'] != null ? TripModel.fromJson(json['trip']) : null;
    status = json['status'];
    createdAt = json['created_at'];
    latitude = json['latitude'] != null ? double.parse(json['latitude']) : null;
    longitude = json['longitude'] != null
        ? double.parse(json['longitude'])
        : null;
    address = json['address'] ?? "";
    points = json['points'].toString();
    code = json['point_code'] ?? "XMSKS44";
  }

  num? id;
  String? name;
  String? phone;
  String? email;
  String? jobTitle;
  Gender? gender;
  String? defaultLang;
  String? image;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? logo;
  String? points;
  num? isProfileCompleted;
  MyAddress? currentAddress;
  String? status;
  String? createdAt;
  String? carPlateNumber;
  TripModel? tripModel;
  double? latitude;
  double? longitude;
  String? address;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['job_title'] = jobTitle;
    map['gender'] = gender;
    map['default_lang'] = defaultLang;
    map['image'] = image;
    map['logo'] = logo;
    map['car_plate_number'] = carPlateNumber;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['profile_image'] = profileImage;
    map['is_profile_completed'] = isProfileCompleted;
    if (currentAddress != null) {
      map['current_address'] = currentAddress?.toJson();
    }
    map['status'] = status;
    map['points'] = points;
    map['created_at'] = createdAt;

    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['address'] = address;
    return map;
  }
}
