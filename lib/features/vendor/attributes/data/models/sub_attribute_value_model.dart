class SubAttributeValueModel {
  SubAttributeValueModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.price,
    this.isSelected,
    this.imagePath,
    this.color,
    this.attributeId,
  });


  num? id;
  String? nameAr;
  String? nameEn;
  double? price;
  bool? isSelected;
  String? imagePath;
  String? color;
  num? attributeId;

  SubAttributeValueModel copyWith({
    num? id,
    String? nameAr,
    String? nameEn,
    double? price,
    bool? isSelected,
    String? imagePath,
    String? color,
    num? attributeId,
  }) =>
      SubAttributeValueModel(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        price: price ?? this.price,
        isSelected: isSelected ?? this.isSelected,
        imagePath: imagePath ?? this.imagePath,
        color: color ?? this.color,
        attributeId: attributeId ?? this.attributeId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = {
      "ar":nameAr,
      "en":nameEn,
    };
    map['price'] = price;
    map['is_selected'] = isSelected;
    map['image_path'] = imagePath;
    map['hex_code'] = color;
    map['attribute_id'] = attributeId;
    return map;
  }
}
