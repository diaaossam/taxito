import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AddProductParams extends Equatable {
  final String? title;
  final String? description;
  final String? price;
  final String? oldPrice;
  final List<String>? images;
  final String? isAvailable;
  final List<int>? productCategories;
  final List<ProductAttribute>? attributes;

  const AddProductParams({
    this.title,
    this.description,
    this.price,
    this.oldPrice,
    this.images,
    this.isAvailable,
    this.productCategories,
    this.attributes,
  });

  Future<FormData> toFormData() async {
    final formData = FormData();

    if (title != null) formData.fields.add(MapEntry('title', title!));
    if (description != null) {
      formData.fields.add(MapEntry('description', description!));
    }
    if (price != null) formData.fields.add(MapEntry('price', price!));
    if (oldPrice != null) formData.fields.add(MapEntry('old_price', oldPrice!));
    if (isAvailable != null) {
      formData.fields.add(MapEntry('is_available', isAvailable!));
    }
    if (productCategories != null && productCategories!.isNotEmpty) {
      for (int i = 0; i < productCategories!.length; i++) {
        formData.fields.add(MapEntry(
            'product_categories[$i]', productCategories![i].toString()));
      }
    }
    if (images != null && images!.isNotEmpty) {
      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(
          images![0],
        ),
      ));
      for (int i = 0; i < images!.length; i++) {
        formData.files.add(MapEntry(
          'images[$i]',
          await MultipartFile.fromFile(
            images![i],
          ),
        ));
      }
    }

    if (attributes != null && attributes!.isNotEmpty) {
      for (int i = 0; i < attributes!.length; i++) {
        final attribute = attributes![i];
        formData.fields.add(MapEntry('attributes[$i][id]', attribute.id.toString()));
        if (attribute.options != null && attribute.options!.isNotEmpty) {
          for (int j = 0; j < attribute.options!.length; j++) {
            final option = attribute.options![j];
            formData.fields.add(MapEntry(
                'attributes[$i][options][$j][title_ar]', option.titleAr));
            formData.fields.add(MapEntry(
                'attributes[$i][options][$j][title_en]', option.titleEn));
            formData.fields.add(MapEntry('attributes[$i][options][$j][price]', option.price));
            if (option.oldPrice != null) {
              formData.fields.add(MapEntry(
                  'attributes[$i][options][$j][old_price]', option.oldPrice!));
            }
            if (option.colorHex != null) {
              formData.fields.add(MapEntry(
                  'attributes[$i][options][$j][hex_code]', option.colorHex!));
            }
            if (option.image != null) {
              final file = option.image!;
              formData.files.add(MapEntry(
                'attributes[$i][options][$j][image]',
                await MultipartFile.fromFile(
                  file.path,
                  filename: 'attribute_option_${i}_${j}.jpg',
                ),
              ));
            }
          }
        }
      }
    }

    return formData;
  }

  AddProductParams copyWith({
    String? title,
    String? description,
    String? price,
    String? oldPrice,
    List<String>? images,
    String? isAvailable,
    List<int>? productCategories,
    List<ProductAttribute>? attributes,
  }) {
    return AddProductParams(
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      images: images ?? this.images,
      isAvailable: isAvailable ?? this.isAvailable,
      productCategories: productCategories ?? this.productCategories,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        price,
        oldPrice,
        images,
        isAvailable,
        productCategories,
        attributes,
      ];
}

class ProductAttribute extends Equatable {
  final int id;
  final List<ProductAttributeOption>? options;

  const ProductAttribute({
    required this.id,
    this.options,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    if (options != null) {
      map['options'] = options!.map((option) => option.toJson()).toList();
    }
    return map;
  }

  ProductAttribute copyWith({
    int? id,
    List<ProductAttributeOption>? options,
  }) {
    return ProductAttribute(
      id: id ?? this.id,
      options: options ?? this.options,
    );
  }

  @override
  List<Object?> get props => [id, options];
}
class ProductAttributeOption extends Equatable {
  final String titleAr;
  final String titleEn;
  final String price;
  final String? oldPrice;
  final File? image;
  final String? colorHex;

  const ProductAttributeOption({
    required this.titleAr,
    required this.titleEn,
    required this.price,
    this.oldPrice,
    this.image,
    this.colorHex,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['title_ar'] = titleAr;
    map['title_en'] = titleEn;
    map['price'] = price;
    map['hex_code'] = colorHex;
    if (oldPrice != null) map['old_price'] = oldPrice;
    if (image != null) map['images'] = image;
    return map;
  }

  ProductAttributeOption copyWith({
    String? titleAr,
    String? titleEn,
    String? price,
    String? oldPrice,
    File? image,
    String? colorHex
  }) {
    return ProductAttributeOption(
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      image: image ?? this.image,
      colorHex: colorHex ??this.colorHex
    );
  }

  @override
  List<Object?> get props => [titleAr, titleEn, price, oldPrice, image,colorHex];
}

