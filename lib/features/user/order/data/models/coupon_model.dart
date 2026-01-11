class CouponModel {
  CouponModel({
    this.isValid,
    this.id,
    this.type,
    this.discountAmount,
    this.finalPrice,
    this.coupon,
  });

  CouponModel.fromJson(dynamic json) {
    isValid = json['is_valid'];
    id = json['id'];
    type = json['type'];
    discountAmount = json['discount_amount'];
    finalPrice = json['final_price'];
    coupon = json['coupon'];
  }

  bool? isValid;
  num? id;
  String? type;
  String? coupon;
  num? discountAmount;
  num? finalPrice;

  CouponModel copyWith({
    bool? isValid,
    num? id,
    String? type,
    String? coupon,
    num? discountAmount,
    num? finalPrice,
  }) =>
      CouponModel(
        isValid: isValid ?? this.isValid,
        id: id ?? this.id,
        type: type ?? this.type,
        discountAmount: discountAmount ?? this.discountAmount,
        finalPrice: finalPrice ?? this.finalPrice,
        coupon: coupon ?? this.coupon,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_valid'] = isValid;
    map['id'] = id;
    map['type'] = type;
    map['discount_amount'] = discountAmount;
    map['coupon'] = coupon;
    map['final_price'] = finalPrice;
    return map;
  }
}
