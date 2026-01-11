class RegisterParams {
  final String? name;
  final String? about;
  final String? email;
  final List<int>? supplierCategories;
  final String? provinceId;
  final String? regionId;
  final String? commercialRegistration;
  final String? profileImage;
  final String? logo;
  final String? foodPreparationTime;
  final String? deliveryTime;
  final String? coverImage;
  final String? address;
  final num? lat;
  final num? lon;

  RegisterParams({
    this.name,
    this.about,
    this.email,
    this.supplierCategories,
    this.provinceId,
    this.regionId,
    this.commercialRegistration,
    this.profileImage,
    this.logo,
    this.foodPreparationTime,
    this.deliveryTime,
    this.coverImage,
    this.lon,
    this.lat,
    this.address,
  });

  factory RegisterParams.fromJson(Map<String, dynamic> json) {
    return RegisterParams(
      name: json['name'] as String?,
      about: json['about'] as String?,
      email: json['email'] as String?,
      supplierCategories:
          (json['supplier_categories'] as List?)?.map((e) => e as int).toList(),
      provinceId: json['province_id'] as String?,
      regionId: json['region_id'] as String?,
      commercialRegistration: json['commercial_registration'] as String?,
      profileImage: json['profile_image'] as String?,
      logo: json['logo'] as String?,
      foodPreparationTime: json['food_preparation_time'] as String?,
      deliveryTime: json['delivery_time'] as String?,
      coverImage: json['cover_image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (about != null) data['about'] = about;
    if (email != null) data['email'] = email;
    if (supplierCategories != null) {
      for (var i = 0; i < supplierCategories!.length; i++) {
        data['supplier_categories[$i]'] = supplierCategories![i];
      }
    }
    if (provinceId != null) data['province_id'] = provinceId;
    if (regionId != null) data['region_id'] = regionId;
    if (logo != null) data['logo'] = logo;
    if (foodPreparationTime != null) {
      data['preparation_time'] = foodPreparationTime;
    }
    if (deliveryTime != null) data['delivery_time'] = deliveryTime;
    if (deliveryTime != null) data['lat'] = lat;
    if (deliveryTime != null) data['lng'] = lon;
    if (deliveryTime != null) data['address'] = address;
    return data;
  }
}
