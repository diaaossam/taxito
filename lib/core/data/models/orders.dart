import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/core/data/models/user_model.dart';
import 'package:taxito/features/captain/delivery_order/data/models/response/my_address.dart';
import 'package:taxito/core/data/models/product_model.dart';

class Orders {
  Orders({
    this.id,
    this.orderNumber,
    this.paymentMethod,
    this.totalPrice,
    this.totalQty,
    this.discountAmount,
    this.discountCode,
    this.shippingCost,
    this.finalPrice,
    this.notes,
    this.address,
    this.status,
    this.driver,
    this.createdAt,
    this.items,
    this.statusLogs,
    this.supplier,
    this.user,
    this.showTimer,
  });

  Orders.fromJson(dynamic json, {bool withTime = false}) {
    showTimer = withTime;
    id = json['id'];
    orderNumber = json['order_number'];
    paymentMethod = json['payment_method'] != null
        ? handleStringToPayment(payment: json['payment_method'])
        : null;
    totalPrice = json['total_price'];
    totalQty = json['total_qty'];
    discountAmount = json['discount_amount'];
    discountCode = json['discount_code'];
    shippingCost = json['shipping_cost'];
    finalPrice = json['final_price'];
    notes = json['notes'];
    address = json['address'] != null
        ? MyAddress.fromJson(json['address'])
        : null;
    supplier = json['supplier'] != null
        ? UserModel.fromJson(json['supplier'])
        : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    status = json['status'] != null
        ? handleStringToOrderType(code: json['status'])
        : OrderType.pending;
    driver = json['driver'] != null ? UserModel.fromJson(json['driver']) : null;
    createdAt = DateTime.parse(json['created_at']);
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
    if (json['status_logs'] != null) {
      statusLogs = [];
      json['status_logs'].forEach((v) {
        statusLogs?.add(StatusLogs.fromJson(v));
      });
    }
  }

  num? id;
  String? orderNumber;
  PaymentType? paymentMethod;
  num? totalPrice;
  num? totalQty;
  num? discountAmount;
  String? discountCode;
  num? shippingCost;
  num? finalPrice;
  String? notes;
  MyAddress? address;
  OrderType? status;
  UserModel? user;
  UserModel? driver;
  DateTime? createdAt;
  UserModel? supplier;
  List<Items>? items;
  List<StatusLogs>? statusLogs;
  bool? showTimer;

  Orders copyWith({
    num? id,
    String? orderNumber,
    PaymentType? paymentMethod,
    num? totalPrice,
    num? totalQty,
    num? discountAmount,
    String? discountCode,
    num? shippingCost,
    num? finalPrice,
    String? notes,
    MyAddress? address,
    OrderType? status,
    UserModel? driver,
    UserModel? user,
    UserModel? supplier,
    DateTime? createdAt,
    List<Items>? items,
    List<StatusLogs>? statusLogs,
    bool? showTimer,
  }) =>
      Orders(
        id: id ?? this.id,
        orderNumber: orderNumber ?? this.orderNumber,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        totalPrice: totalPrice ?? this.totalPrice,
        totalQty: totalQty ?? this.totalQty,
        discountAmount: discountAmount ?? this.discountAmount,
        discountCode: discountCode ?? this.discountCode,
        shippingCost: shippingCost ?? this.shippingCost,
        finalPrice: finalPrice ?? this.finalPrice,
        notes: notes ?? this.notes,
        address: address ?? this.address,
        status: status ?? this.status,
        driver: driver ?? this.driver,
        user: user ?? this.user,
        supplier: supplier ?? this.supplier,
        createdAt: createdAt ?? this.createdAt,
        items: items ?? this.items,
        statusLogs: statusLogs ?? this.statusLogs,
        showTimer: showTimer ?? this.showTimer,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_number'] = orderNumber;
    map['payment_method'] = paymentMethod;
    map['total_price'] = totalPrice;
    map['total_qty'] = totalQty;
    map['discount_amount'] = discountAmount;
    map['discount_code'] = discountCode;
    map['shipping_cost'] = shippingCost;
    map['final_price'] = finalPrice;
    map['notes'] = notes;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['status'] = status;
    if (driver != null) {
      map['driver'] = driver?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (supplier != null) {
      map['supplier'] = supplier?.toJson();
    }
    map['created_at'] = createdAt?.toIso8601String();
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    if (statusLogs != null) {
      map['status_logs'] = statusLogs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class StatusLogs {
  StatusLogs({
    this.id,
    this.status,
    this.createdAt,
  });

  StatusLogs.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'] != null
        ? handleStringToOrderType(code: json['status'])
        : null;
    createdAt = DateTime.parse(json['created_at']);
  }

  num? id;
  OrderType? status;
  DateTime? createdAt;

  StatusLogs copyWith({
    num? id,
    OrderType? status,
    DateTime? createdAt,
  }) =>
      StatusLogs(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['created_at'] = createdAt?.toIso8601String();
    return map;
  }
}

class Items {
  Items({
    this.product,
    this.isProductDeleted,
    this.isProductActive,
    this.isProductRated,
    this.productRate,
    this.notes,
    this.qty,
    this.price,
    this.totalPrice,
    this.attributes,
  });

  Items.fromJson(dynamic json) {
    product = json['product'] != null
        ? ProductModel.fromJson(json['product'])
        : null;
    isProductDeleted = json['is_product_deleted'];
    isProductActive = json['is_product_active'];
    isProductRated = json['is_product_rated'];
    productRate = json['product_rate'];
    notes = json['notes'];
    qty = json['qty'];
    price = json['price'];
    totalPrice = json['total_price'];
  }

  ProductModel? product;
  bool? isProductDeleted;
  bool? isProductActive;
  bool? isProductRated;
  dynamic productRate;
  dynamic notes;
  num? qty;
  num? price;
  num? totalPrice;
  List<dynamic>? attributes;

  Items copyWith({
    ProductModel? product,
    bool? isProductDeleted,
    bool? isProductActive,
    bool? isProductRated,
    dynamic productRate,
    dynamic notes,
    num? qty,
    num? price,
    num? totalPrice,
    List<dynamic>? attributes,
  }) =>
      Items(
        product: product ?? this.product,
        isProductDeleted: isProductDeleted ?? this.isProductDeleted,
        isProductActive: isProductActive ?? this.isProductActive,
        isProductRated: isProductRated ?? this.isProductRated,
        productRate: productRate ?? this.productRate,
        notes: notes ?? this.notes,
        qty: qty ?? this.qty,
        price: price ?? this.price,
        totalPrice: totalPrice ?? this.totalPrice,
        attributes: attributes ?? this.attributes,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (product != null) {
      map['product'] = product?.toJson();
    }
    map['is_product_deleted'] = isProductDeleted;
    map['is_product_active'] = isProductActive;
    map['is_product_rated'] = isProductRated;
    map['product_rate'] = productRate;
    map['notes'] = notes;
    map['qty'] = qty;
    map['price'] = price;
    map['total_price'] = totalPrice;
    if (attributes != null) {
      map['attributes'] = attributes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
