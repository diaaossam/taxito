import 'package:taxito/core/enum/choose_enum.dart';
import 'package:taxito/features/captain/app/data/models/generic_model.dart';
import 'package:taxito/features/captain/driver_trip/data/models/trip_model.dart';

class UserModel {
  UserModel({
    this.id,
    this.driverType,
    this.name,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.email,
    this.phone,
    this.province,
    this.carPlateNumber,
    this.vehicleType,
    this.idFrontImage,
    this.idBackImage,
    this.driverLicenseFrontImage,
    this.driverLicenseBackImage,
    this.cars,
    this.carInsuranceFrontImage,
    this.carInsuranceBackImage,
    this.status,
    this.isAvailable,
    this.address,
    this.latitude,
    this.longitude,
    this.isProfileCompleted,
    this.defaultLang,
    this.enableNotifications,
    this.createdAt,
    this.updatedAt,
    this.tripModel,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    driverType = json['driver_type'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['profile_image'] ?? json['image'] ?? json['logo'];
    email = json['email'];
    phone = json['phone'];
    province = json['province'] != null
        ? GenericModel.fromJson(json['province'])
        : null;
    carPlateNumber = json['car_plate_number'];
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
    status = json['status'];
    isAvailable = json['is_available'] == 1 ? ChooseEnum.yes : ChooseEnum.no;
    address = json['address'] ?? "";
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    isProfileCompleted = json['is_profile_completed'];
    defaultLang = json['default_lang'];
    enableNotifications = json['enable_notifications'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tripModel = json['trip'] != null ? TripModel.fromJson(json['trip']) : null;
  }

  num? id;
  String? driverType;
  String? name;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? email;
  String? phone;
  GenericModel? province;
  String? carPlateNumber;
  String? vehicleType;
  String? idFrontImage;
  String? idBackImage;
  String? driverLicenseFrontImage;
  String? driverLicenseBackImage;
  List<Cars>? cars;
  String? carInsuranceFrontImage;
  String? carInsuranceBackImage;
  String? status;
  ChooseEnum? isAvailable;
  String? address;
  String? latitude;
  String? longitude;
  num? isProfileCompleted;
  String? defaultLang;
  num? enableNotifications;
  String? createdAt;
  String? updatedAt;
  TripModel? tripModel;
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
