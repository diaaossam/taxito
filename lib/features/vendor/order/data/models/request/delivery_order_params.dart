import 'package:taxito/core/enum/order_type.dart';

class DeliveryParams {
  final OrderType? status;
  final int? pageKey;

  DeliveryParams({required this.status, this.pageKey = 1});

  Map<String, dynamic> toJson() => {
        "page": pageKey,
        "status": status?.name,
      };
}
