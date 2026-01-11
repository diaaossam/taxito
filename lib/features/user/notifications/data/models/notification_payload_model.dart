
class NotificationPayloadModel {
  NotificationPayloadModel({
      this.chatUuid, 
      this.icon, 
      this.body, 
      this.type, 
      this.title, 
      this.clickAction, 
      this.senderId, 
      this.chatId,});

  NotificationPayloadModel.fromJson(dynamic json) {
    chatUuid = json['chat_uuid'];
    icon = json['icon'];
    body = json['body'];
    type = json['type'];
    title = json['title'];
    clickAction = json['click_action'];
    senderId = json['user_id']?.toString();
    chatId = json['chat_id'];
  }
  String? chatUuid;
  dynamic icon;
  String? body;
  String? type;
  String? title;
  String? clickAction;
  String? senderId;
  String? chatId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chat_uuid'] = chatUuid;
    map['icon'] = icon;
    map['body'] = body;
    map['type'] = type;
    map['title'] = title;
    map['click_action'] = clickAction;
    map['sender_id'] = senderId;
    map['chat_id'] = chatId;
    return map;
  }

}