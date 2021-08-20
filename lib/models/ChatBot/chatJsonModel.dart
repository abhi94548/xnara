import 'dart:convert';

List<ChatJsonModel> chatJsonModelFromJson(String str) => List<ChatJsonModel>.from(json.decode(str).map((x) => ChatJsonModel.fromJson(x)));

String chatJsonModelToJson(List<ChatJsonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatJsonModel {
  ChatJsonModel({
    required this.agent,
    required this.payload,
  });

  String agent;
  Payload payload;

  factory ChatJsonModel.fromJson(Map<String, dynamic> json) => ChatJsonModel(
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