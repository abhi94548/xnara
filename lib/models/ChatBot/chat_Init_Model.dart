import 'dart:convert';

ChatInitModel chatInitModelFromJson(String str) => ChatInitModel.fromJson(json.decode(str) as Map<String,dynamic>);

String chatInitModelToJson(ChatInitModel data) => json.encode(data.toJson());

class ChatInitModel {
  ChatInitModel({
    required this.success,
    this.sessionId,
  });

  factory ChatInitModel.fromJson(Map<String, dynamic> json) => ChatInitModel(
    sessionId: json['sessionId'].toString(),
    success: json['success'] as bool,
  );

  String? sessionId;
  bool success;

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'success': success,
  };
}
