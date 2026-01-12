import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/features/user/product/data/models/product_model.dart';

class CartModel {
  CartModel(
      {this.addressId,
      this.discountCode,
      this.items,
      this.note,
      this.paymentType});

  num? addressId;
  String? discountCode;
  String? note;
  List<CartItem>? items;
  PaymentType? paymentType;

  CartModel copyWith(
          {num? addressId,
          String? discountCode,
          List<CartItem>? items,
          String? note,
          PaymentType? paymentType}) =>
      CartModel(
          addressId: addressId ?? this.addressId,
          discountCode: discountCode ?? this.discountCode,
          items: items ?? this.items,
          paymentType: paymentType ?? this.paymentType,
          note: note ?? this.note);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_id'] = addressId;
    map['discount_code'] = discountCode;
    map['note'] = note;
    map['payment_method'] = paymentType?.name;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJsonForLocaleDataBase()).toList();
    }

    map.removeWhere((key, value) => value==null,);
    return map;
  }
}

class CartItem {
  CartItem(
      {this.productId,
      this.qty,
      this.price,
      this.productModel,
      this.currentItemPrice,
      this.uniqueProductId,
      this.productAttributes,
      this.notes,
      this.stock});

  CartItem.fromJson(dynamic json) {
    uniqueProductId = json['uniqueProductId'];
    productId = json['product_id'];
    qty = json['qty'];
    price = json['price'];
    currentItemPrice = json['currentItemPrice'];
    notes = json['notes'];
    stock = json['stock'];
    productModel =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    if (json['product_attributes'] != null) {
      productAttributes = [];
      json['product_attributes'].forEach((v) {
        productAttributes?.add(ProductAttributes.fromJson(v));
      });
    }
  }

  String? uniqueProductId;
  num? productId;
  num? qty;
  String? notes;
  num? price;
  num? currentItemPrice;
  num? stock;
  List<ProductAttributes>? productAttributes;
  ProductModel? productModel;

  CartItem copyWith({
    num? productId,
    num? qty,
    num? price,
    num? currentItemPrice,
    ProductModel? productModel,
    String? uniqueProductId,
    String? notes,
    num? stock,
    List<ProductAttributes>? productAttributes,
  }) =>
      CartItem(
          uniqueProductId: uniqueProductId ?? this.uniqueProductId,
          productId: productId ?? this.productId,
          qty: qty ?? this.qty,
          price: price ?? this.price,
          notes: notes ?? this.notes,
          stock: stock ?? this.stock,
          productAttributes: productAttributes ?? this.productAttributes,
          productModel: productModel ?? this.productModel,
          currentItemPrice: currentItemPrice ?? this.currentItemPrice);

  Map<String, dynamic> toJsonForLocaleDataBase() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['qty'] = qty;
    map['price'] = price;
    map['notes'] = notes;
    map['stock'] = stock;
    map['uniqueProductId'] = uniqueProductId;
    map['currentItemPrice'] = currentItemPrice;
    map['product'] = productModel?.toJson();
    if (productAttributes != null) {
      map['product_attributes'] =
          productAttributes?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}

class ProductAttributes {
  ProductAttributes({
    this.attribute,
    this.attributeValues,
  });

  ProductAttributes.fromJson(dynamic json) {
    attribute = json['attribute'];
    attributeValues = json['attribute_values'] != null
        ? json['attribute_values'].cast<num>()
        : [];
  }

  num? attribute;
  List<num>? attributeValues;

  ProductAttributes copyWith({
    num? attribute,
    List<num>? attributeValues,
  }) =>
      ProductAttributes(
        attribute: attribute ?? this.attribute,
        attributeValues: attributeValues ?? this.attributeValues,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attribute'] = attribute;
    map['attribute_values'] = attributeValues;
    return map;
  }
}
