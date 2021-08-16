class ChatModel {
  final String message;
  final String? sessionId;

  ChatModel({required this.message, this.sessionId});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(message: json['Message'], sessionId: json['sessionId']);
  }
}
