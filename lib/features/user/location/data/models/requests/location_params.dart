class SavedLocationParams {
  final num? provinceId;
  final num? regionId;
  final double? lat;
  final double? lng;
  final String? name;
  final String? phone;
  final String? address;
  final String? notes;
  final num? isDefault;

  SavedLocationParams(
      {this.provinceId,
      this.regionId,
      this.lat,
      this.lng,
      this.name,
      this.phone,
      this.address,
      this.isDefault = 0,
      this.notes});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['province_id'] = provinceId;
    map['region_id'] = regionId;
    map['latitude'] = lat;
    map['longitude'] = lng;
    map['name'] = name;
    map['address'] = address;
    map['phone'] = phone;
    map['notes'] = notes;
    map['is_default'] = isDefault;
    map.removeWhere(
      (key, value) => value == null,
    );
    return map;
  }

  /// make copy with method
  SavedLocationParams copyWith({
    num? provinceId,
    num? regionId,
    num? isDefault,
    double? lat,
    double? lng,
    String? name,
    String? phone,
    String? address,
    String? notes,
  }) {
    return SavedLocationParams(
      isDefault: isDefault ?? this.isDefault,
      provinceId: provinceId ?? this.provinceId,
      regionId: regionId ?? this.regionId,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      notes: notes ?? this.notes,
    );
  }
}
