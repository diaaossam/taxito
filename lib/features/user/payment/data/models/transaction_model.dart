class TransactionModel {
  TransactionModel({
      this.id, 
      this.amount, 
      this.type, 
      this.description, 
      this.orderId, 
      this.createdAt,});

  TransactionModel.fromJson(dynamic json) {
    id = json['id'];
    amount = json['amount'];
    type = json['type'];
    description = json['description'];
    orderId = json['order_id'];
    createdAt = json['created_at'];
  }
  num? id;
  num? amount;
  String? type;
  String? description;
  dynamic orderId;
  String? createdAt;
TransactionModel copyWith({  num? id,
  num? amount,
  String? type,
  String? description,
  dynamic orderId,
  String? createdAt,
}) => TransactionModel(  id: id ?? this.id,
  amount: amount ?? this.amount,
  type: type ?? this.type,
  description: description ?? this.description,
  orderId: orderId ?? this.orderId,
  createdAt: createdAt ?? this.createdAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['amount'] = amount;
    map['type'] = type;
    map['description'] = description;
    map['order_id'] = orderId;
    map['created_at'] = createdAt;
    return map;
  }

}