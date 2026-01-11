class StaticsModel {
  StaticsModel(
      {this.total, this.completed, this.profits, this.canceled, this.rating});

  StaticsModel.fromJson(dynamic json) {
    total = json['total'] ?? 0;
    completed = json['completed'] ?? 0;
    profits = json['total_profit'] ?? 0;
    canceled = json['canceled'] ?? 0;
    rating = json['rate'] ?? 0;
  }

  num? total;
  num? completed;
  num? profits;
  num? rating;
  num? canceled;
}
