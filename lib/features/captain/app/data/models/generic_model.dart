import 'package:equatable/equatable.dart';
class GenericModel extends Equatable {
  final int? id;
  final String? title;
  final String? titleAr;
  final String? titleEn;
  final String? description;
  final String? image;
  final num? deliveryPrice;

  const GenericModel(
      {required this.id,
        required this.title,
        this.description,
        this.deliveryPrice,
        this.image,
        this.titleAr,
        this.titleEn});

  factory GenericModel.fromJson(Map<String, dynamic> map) => GenericModel(
    id: map['id'],
    title: map['title'],
    deliveryPrice: map['delivery_price'],
    description: map['description'],
    image: map['image'],
    titleAr: map['title_ar'],
    titleEn: map['title_en'],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    if (description != null) "description": description,
    if (deliveryPrice != null) "delivery_price": deliveryPrice,
    if (image != null) "image": image,
  };

  @override
  List<Object?> get props =>
      [id, title, deliveryPrice, description, image, titleAr, titleEn];
}
