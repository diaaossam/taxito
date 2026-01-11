import '../../../../captain/auth/data/models/response/user_model.dart';

class MessageModel {
  MessageModel({
    this.id,
    this.message,
    this.sendBy,
    this.isRead,
    this.user,
    this.driver,
    this.createdAt,
  });

  MessageModel.fromJson(dynamic json) {
    id = json['id'];
    message = json['message'];
    sendBy = json['send_by'];
    isRead = json['is_read'] is num ? json['is_read'] == 1 : json['is_read'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    driver = json['driver'] != null ? UserModel.fromJson(json['driver']) : null;
    createdAt = json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : null;
  }

  num? id;
  String? message;
  String? sendBy;
  bool? isRead;
  UserModel? user;
  UserModel? driver;
  DateTime? createdAt;
}
