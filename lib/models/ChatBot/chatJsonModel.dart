// To parse this JSON data, do
//
//     final chatJsonModel = chatJsonModelFromJson(jsonString);

import 'dart:convert';

ChatJsonModel chatJsonModelFromJson(String str) => ChatJsonModel.fromJson(json.decode(str));

String chatJsonModelToJson(ChatJsonModel data) => json.encode(data.toJson());

class ChatJsonModel {
  ChatJsonModel({
    required this.messages,
  });

  List<Message> messages;

  factory ChatJsonModel.fromJson(Map<String, dynamic> json) => ChatJsonModel(
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

class Message {
  Message({
    required this.payload,
    required this.agent,
  });

  Payload payload;
  String agent;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    payload: Payload.fromJson(json["payload"]),
    agent: json["agent"],
  );

  Map<String, dynamic> toJson() => {
    "payload": payload.toJson(),
    "agent": agent,
  };
}

class Payload {
  Payload({
    required this.text,
  });

  String text;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
  };
}
