class RegisterParams {
  final String? name;
  final String? userType;
  final String? email;
  final String? phone;
  final String? carPlateNumber;
  final String? profileImage;
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

  RegisterParams(
      {this.name,
      this.userType,
      this.phone,
      this.carPlateNumber,
      this.uid,
      this.email,
      this.profileImage,
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
      this.backInsurancePhoto});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'first_name': firstName,
      'last_name': lastName,
      if (userType != null) "user_type": userType,
      if (phone != null) "phone": phone,
      if (carPlateNumber != null) "car_plate_number": carPlateNumber,
      'name': name,
      'email': email,
      'province_id': governorateId,
      'phone': phone,
    };
    map.removeWhere(
      (key, value) => value == null,
    );
    return map;
  }

  RegisterParams copyWith({
    String? name,
    String? userType,
    String? phone,
    String? uid,
    bool? isUpdate,
    String? accountType,
    String? firstName,
    String? lastName,
    int? governorateId,
    String? carPlateNumber,
    String? profileImage,
    String? frontIdImage,
    String? backIdImage,
    String? frontDriverLicense,
    String? backDriverLicense,
    String? frontImage,
    String? carModel,
    String? backImage,
    String? email,
    List<String>? carImages,
    String? frontInsurancePhoto,
    String? backInsurancePhoto,
  }) {
    return RegisterParams(
        name: name ?? this.name,
        userType: userType ?? this.userType,
        phone: phone ?? this.phone,
        uid: uid ?? this.uid,
        carPlateNumber: carPlateNumber ?? this.carPlateNumber,
        profileImage: profileImage ?? this.profileImage,
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
        email: email ?? this.email);
  }
}
