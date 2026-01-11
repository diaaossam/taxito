class NotificationParams {
  final bool? enableChatNotifications;
  final bool? enableVisitNotifications;
  final bool? enableInterestNotifications;

  NotificationParams(
      {required this.enableChatNotifications,
      required this.enableVisitNotifications,
      required this.enableInterestNotifications});

  Map<String, dynamic> toJson() => {
        "enable_chat_notifications": enableChatNotifications! ? 1 : 0,
        "enable_visit_notifications": enableVisitNotifications! ? 1 : 0,
        "enable_interest_notifications": enableInterestNotifications! ? 1 : 0,
      };
}
