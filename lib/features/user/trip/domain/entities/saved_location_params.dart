class SavedLocationParams {
  SavedLocationParams({
    this.address,
    this.mapAddress,
    this.lat,
    this.lng,
    this.notes,
  });

  String? address;
  String? mapAddress;
  double? lat;
  double? lng;
  String? notes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['map_address'] = mapAddress;
    map['lat'] = lat;
    map['lng'] = lng;
    map['notes'] = notes;
    map.removeWhere((key, value) => value.toString().isEmpty,);
    return map;
  }
}
