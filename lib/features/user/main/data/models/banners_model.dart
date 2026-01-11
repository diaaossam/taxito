class BannersModel {
  BannersModel({
    this.id,
    this.title,
    this.image,
  });

  BannersModel.fromJson(
    dynamic json,
  ) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  num? id;
  String? title;
  String? image;

  BannersModel copyWith({
    num? id,
    String? title,
    String? image,
  }) =>
      BannersModel(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    return map;
  }
}
