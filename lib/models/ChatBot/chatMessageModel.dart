// To parse this JSON data, do
//
//     final chatMessageModel = chatMessageModelFromJson(jsonString);

import 'dart:convert';

ChatMessageModel chatMessageModelFromJson(String str) => ChatMessageModel.fromJson(json.decode(str));

String chatMessageModelToJson(ChatMessageModel data) => json.encode(data.toJson());

class ChatMessageModel {
  ChatMessageModel({
    required this.messages,
    required this.sessionId,
    required this.success,
  });

  List<Message> messages;
  String sessionId;
  bool success;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    sessionId: json["sessionId"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    "sessionId": sessionId,
    "success": success,
  };
}

class Message {
  Message({
    required this.agent,
    required this.payload,
  });

  String agent;
  Payload payload;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    agent: json["agent"],
    payload: Payload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "agent": agent,
    "payload": payload.toJson(),
  };
}

class Payload {
  Payload({
    this.text,
  });

  List<dynamic>? text;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    text: List<dynamic>.from(json["text"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "text": List<dynamic>.from(text!.map((x) => x)),
  };
}
