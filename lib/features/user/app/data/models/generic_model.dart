import 'package:equatable/equatable.dart';

class GenericModel extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final num? deliveryPrice;

  const GenericModel({
    required this.id,
    required this.title,
    this.description,
    this.deliveryPrice,
  });

  factory GenericModel.fromJson(Map<String, dynamic> map) => GenericModel(
        id: map['id'],
        title: map['title'],
        deliveryPrice: map['delivery_price'],
        description: map['description'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        if (description != null) "description": description,
        if (deliveryPrice != null) "delivery_price": deliveryPrice,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        deliveryPrice,
        description,
      ];
}
