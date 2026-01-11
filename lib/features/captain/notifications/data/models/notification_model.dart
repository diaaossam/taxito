class NotificationModel {
  NotificationModel(
      {this.id,
      this.title,
      this.description,
      this.isRead,
      this.readAt,
      this.readAtForHumans,
      this.createdAt,
      this.icon});

  NotificationModel.fromJson(dynamic json) {
    id = json['id'];
    icon = json['icon'];
    title = json['title'];
    description = json['description'];
    isRead = json['is_read'];
    readAt = json['read_at'];
    readAtForHumans = json['created_at_for_humans'];
    createdAt = json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : DateTime.now();
  }

  String? id;
  String? title;
  String? description;
  bool? isRead;
  String? readAt;
  String? readAtForHumans;
  String? icon;
  DateTime? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['is_read'] = isRead;
    map['read_at'] = readAt;
    map['created_at_for_humans'] = readAtForHumans;
    map['created_at'] = createdAt;
    map['icon'] = icon;
    return map;
  }
}
