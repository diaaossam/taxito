class ReviewBodyModel {
  final String comment;
  final String rating;
  final String orderId;
  final String productId;

  ReviewBodyModel(
      {required this.comment,
      required this.rating,
      required this.orderId,
      required this.productId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review'] = comment;
    data['product_id'] = productId;
    data['rating'] = rating;
    return data;
  }
}
