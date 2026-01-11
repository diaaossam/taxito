class AttributesModel {
  AttributesModel({
    this.attributeId,
    this.title,
    this.isRequired,
    this.isMultiple,
    this.isColor,
    this.values,
  });

  AttributesModel.fromJson(dynamic json) {
    attributeId = json['attribute_id'];
    title = json['title'];
    isRequired = json['is_required'];
    isMultiple = json['is_multiple'];
    isColor = json['is_color'];
    if (json['values'] != null) {
      values = [];
      json['values'].forEach((v) {
        values?.add(Values.fromJson(v));
      });
    }
  }

  num? attributeId;
  String? title;
  num? isRequired;
  num? isMultiple;
  num? isColor;
  List<Values>? values;

  AttributesModel copyWith({
    num? attributeId,
    String? title,
    num? isRequired,
    num? isMultiple,
    num? isColor,
    List<Values>? values,
  }) =>
      AttributesModel(
        attributeId: attributeId ?? this.attributeId,
        title: title ?? this.title,
        isRequired: isRequired ?? this.isRequired,
        isMultiple: isMultiple ?? this.isMultiple,
        isColor: isColor ?? this.isColor,
        values: values ?? this.values,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attribute_id'] = attributeId;
    map['title'] = title;
    map['is_required'] = isRequired;
    map['is_multiple'] = isMultiple;
    map['is_color'] = isColor;
    if (values != null) {
      map['values'] = values?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Values {
  Values({
    this.attributeValueId,
    this.title,
    this.price,
    this.hexCode,
    this.qty,
    this.image,
  });

  Values.fromJson(dynamic json) {
    attributeValueId = json['attribute_value_id'];
    title = json['title'];
    price = json['price'];
    hexCode = json['hex_code'];
    qty = json['qty'];
    image = json['image'];
  }

  num? attributeValueId;
  String? title;
  num? price;
  String? hexCode;
  num? qty;
  String? image;

  Values copyWith({
    num? attributeValueId,
    String? title,
    num? price,
    String? hexCode,
    num? qty,
    String? image,
  }) =>
      Values(
        attributeValueId: attributeValueId ?? this.attributeValueId,
        title: title ?? this.title,
        price: price ?? this.price,
        hexCode: hexCode ?? this.hexCode,
        qty: qty ?? this.qty,
        image: image ?? this.image,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attribute_value_id'] = attributeValueId;
    map['title'] = title;
    map['price'] = price;
    map['hex_code'] = hexCode;
    map['qty'] = qty;
    map['image'] = image;
    return map;
  }
}
