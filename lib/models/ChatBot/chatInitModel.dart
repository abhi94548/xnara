import 'dart:convert';

ChatInitModel chatInitModelFromJson(String str) => ChatInitModel.fromJson(json.decode(str));

String chatInitModelToJson(ChatInitModel data) => json.encode(data.toJson());

class ChatInitModel {
  ChatInitModel({
    this.sessionId,
    required this.success,
  });

  String? sessionId;
  bool success;

  factory ChatInitModel.fromJson(Map<String, dynamic> json) => ChatInitModel(
    sessionId: json["sessionId"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "sessionId": sessionId,
    "success": success,
  };
}
