import 'package:equatable/equatable.dart';

class PromoCodeParams extends Equatable {
  final String coupon;
  final String totalPrice;

  const PromoCodeParams({required this.coupon, required this.totalPrice});

  @override
  List<Object> get props => [coupon, totalPrice];

  Map<String, dynamic> toJson() =>
      {"coupon_code": coupon, "total_price": totalPrice};
}
