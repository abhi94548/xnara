import 'dart:convert';


List<ChatJsonModel> chatJsonModelFromJson(String str) => List<ChatJsonModel>.from(json.decode(str).map((x) => ChatJsonModel.fromJson(x as Map<String,dynamic>)) as Iterable<dynamic>);

String chatJsonModelToJson(List<ChatJsonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ChatJsonModel {
  ChatJsonModel({
    required this.agent,
    required this.payload,
  });

  factory ChatJsonModel.fromJson(Map<String, dynamic> json) => ChatJsonModel(
    agent: json['agent'] as String,
    payload: Payload.fromJson(json['payload'] as Map<String,dynamic>),
  );

  String agent;
  Payload payload;



  Map<String, dynamic> toJson() => {
    'agent': agent,
    'payload': payload.toJson(),
  };
}

class Payload {
  Payload({
    required this.text,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    text: json['text'] as String,
  );

  String text;

  Map<String, dynamic> toJson() => {
    'text': text,
  };
}