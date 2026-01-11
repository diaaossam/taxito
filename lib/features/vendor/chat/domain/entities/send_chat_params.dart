class SendChatParams {
  final String message;

  SendChatParams({required this.message});

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
