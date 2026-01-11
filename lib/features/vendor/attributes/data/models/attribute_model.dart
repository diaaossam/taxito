class AttributeModel {
  AttributeModel({
      this.id, 
      this.title, 
      this.titleAr, 
      this.titleEn, 
      this.isRequired, 
      this.isMultiple, 
      this.isColor, 
      this.createdAt, 
      this.updatedAt,});

  AttributeModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
    isRequired = json['is_required']==1;
    isMultiple = json['is_multiple']==1;
    isColor = json['is_color']==1;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? title;
  String? titleAr;
  String? titleEn;
  bool? isRequired;
  bool? isMultiple;
  bool? isColor;
  String? createdAt;
  String? updatedAt;
AttributeModel copyWith({  num? id,
  String? title,
  String? titleAr,
  String? titleEn,
  bool? isRequired,
  bool? isMultiple,
  bool? isColor,
  String? createdAt,
  String? updatedAt,
}) => AttributeModel(  id: id ?? this.id,
  title: title ?? this.title,
  titleAr: titleAr ?? this.titleAr,
  titleEn: titleEn ?? this.titleEn,
  isRequired: isRequired ?? this.isRequired,
  isMultiple: isMultiple ?? this.isMultiple,
  isColor: isColor ?? this.isColor,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['title_ar'] = titleAr;
    map['title_en'] = titleEn;
    map['is_required'] = isRequired;
    map['is_multiple'] = isMultiple;
    map['is_color'] = isColor;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}