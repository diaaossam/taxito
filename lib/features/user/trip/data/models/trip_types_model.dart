class TripTypesModel {
  TripTypesModel({
      this.id, 
      this.title, 
      this.image, 
      this.basePrice, 
      this.pricePerKilometer,});

  TripTypesModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    basePrice = json['base_price'];
    pricePerKilometer = json['price_per_kilometer'];
  }
  num? id;
  String? title;
  String? image;
  num? basePrice;
  num? pricePerKilometer;
TripTypesModel copyWith({  num? id,
  String? title,
  String? image,
  num? basePrice,
  num? pricePerKilometer,
}) => TripTypesModel(  id: id ?? this.id,
  title: title ?? this.title,
  image: image ?? this.image,
  basePrice: basePrice ?? this.basePrice,
  pricePerKilometer: pricePerKilometer ?? this.pricePerKilometer,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    map['base_price'] = basePrice;
    map['price_per_kilometer'] = pricePerKilometer;
    return map;
  }

}