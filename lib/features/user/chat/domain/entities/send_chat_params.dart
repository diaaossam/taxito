class SendChatParams {
  final String message;
  final num tripId;
  final String chatUuid;

  SendChatParams(
      {required this.message, required this.tripId, required this.chatUuid});

  Map<String, dynamic> toJson() => {
        if (tripId != 0) "trip_id": tripId,
        "message": message,
      };
}
