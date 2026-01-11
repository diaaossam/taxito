class SavedLocationModel {
  SavedLocationModel({
      this.id, 
      this.address, 
      this.mapAddress, 
      this.lat, 
      this.lng, 
      this.notes, 
      this.createdAt,});

  SavedLocationModel.fromJson(dynamic json) {
    id = json['id'];
    address = json['address'];
    mapAddress = json['map_address'];
    lat = json['lat'];
    lng = json['lng'];
    notes = json['notes'];
    createdAt = json['created_at'];
  }
  num? id;
  String? address;
  String? mapAddress;
  String? lat;
  String? lng;
  dynamic notes;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['address'] = address;
    map['map_address'] = mapAddress;
    map['lat'] = lat;
    map['lng'] = lng;
    map['notes'] = notes;
    map['created_at'] = createdAt;
    return map;
  }

}