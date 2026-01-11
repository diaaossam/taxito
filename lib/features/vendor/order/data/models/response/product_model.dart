import '../../../../../captain/app/data/models/generic_model.dart';
import 'attributes_model.dart';
import 'supplier_model.dart';

class ProductModel {
  ProductModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.oldPrice,
    this.percentageDiscount,
    this.reviewsCount,
    this.reviewsAvg,
    this.qty,
    this.image,
    this.images,
    this.isAddedToFavourite,
    this.attributes,
    this.isAvailable,
    this.categories,
  });

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    oldPrice = json['old_price'];
    percentageDiscount = json['percentage_discount'] ?? 0;
    reviewsCount = json['reviews_count'];
    reviewsAvg = json['reviews_avg'];
    isAvailable = json['is_available'];
    qty = json['qty'];
    if (json['image'] is List) {
      images = [];
      json['image'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    } else {
      image = json['image'] != null ? Images.fromJson(json['image']) : null;
    }

    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add(AttributesModel.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(GenericModel.fromJson(v));
      });
    }
    isAddedToFavourite = json['is_added_to_favourite'];
  }

  num? id;
  String? title;
  String? description;
  num? price;
  num? oldPrice;
  num? percentageDiscount;
  num? reviewsCount;
  num? reviewsAvg;
  num? isAvailable;
  dynamic qty;
  Images? image;
  List<Images>? images;
  List<AttributesModel>? attributes;
  List<GenericModel>? categories;
  bool? isAddedToFavourite;

  ProductModel copyWith({
    num? id,
    String? title,
    String? description,
    num? price,
    num? oldPrice,
    num? percentageDiscount,
    num? reviewsCount,
    num? reviewsAvg,
    num? isAvailable,
    dynamic qty,
    Images? image,
    List<Images>? images,
    bool? isAddedToFavourite,
    List<AttributesModel>? attributes,
  }) => ProductModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    price: price ?? this.price,
    oldPrice: oldPrice ?? this.oldPrice,
    percentageDiscount: percentageDiscount ?? this.percentageDiscount,
    reviewsCount: reviewsCount ?? this.reviewsCount,
    reviewsAvg: reviewsAvg ?? this.reviewsAvg,
    qty: qty ?? this.qty,
    image: image ?? this.image,
    images: images ?? this.images,
    isAddedToFavourite: isAddedToFavourite ?? this.isAddedToFavourite,
    attributes: attributes ?? this.attributes,
    isAvailable: isAvailable ?? this.isAvailable,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['price'] = price;
    map['old_price'] = oldPrice;
    map['percentage_discount'] = percentageDiscount;
    map['is_available'] = isAvailable;
    map['reviews_count'] = reviewsCount;
    map['reviews_avg'] = reviewsAvg;
    map['qty'] = qty;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      map['attributes'] = attributes?.map((v) => v.toJson()).toList();
    }
    map['is_added_to_favourite'] = isAddedToFavourite;
    return map;
  }
}

class Images {
  Images({this.uuid, this.url});

  Images.fromJson(dynamic json) {
    uuid = json['uuid'];
    url = json['url'];
  }

  String? uuid;
  String? url;

  Images copyWith({String? uuid, String? url}) =>
      Images(uuid: uuid ?? this.uuid, url: url ?? this.url);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = uuid;
    map['url'] = url;
    return map;
  }
}
