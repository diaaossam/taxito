class StaticsModel {
  StaticsModel({
    this.newOrders,
    this.rejectedOrders,
    this.completedOrders,
    this.totalProfit,
    this.rate,
  });

  StaticsModel.fromJson(dynamic json) {
    newOrders = json['new_orders'];
    rejectedOrders = json['rejected_orders'];
    completedOrders = json['completed_orders'];
    totalProfit = json['total_profit'];
    rate = json['rate'].toString();
  }

  num? newOrders;
  num? rejectedOrders;
  num? completedOrders;
  num? totalProfit;
  String? rate;

  StaticsModel copyWith({
    num? newOrders,
    num? rejectedOrders,
    num? completedOrders,
    num? totalProfit,
    String? rate,
  }) =>
      StaticsModel(
        newOrders: newOrders ?? this.newOrders,
        rejectedOrders: rejectedOrders ?? this.rejectedOrders,
        completedOrders: completedOrders ?? this.completedOrders,
        totalProfit: totalProfit ?? this.totalProfit,
        rate: rate ?? this.rate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['new_orders'] = newOrders;
    map['rejected_orders'] = rejectedOrders;
    map['completed_orders'] = completedOrders;
    map['total_profit'] = totalProfit;
    map['rate'] = rate;
    return map;
  }
}
