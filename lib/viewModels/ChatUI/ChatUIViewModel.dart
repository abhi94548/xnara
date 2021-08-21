import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:xnara/models/ChatBot/HiveMessageModel.dart';
import '../../models/ChatBot/MessageModel.dart';
import '../../models/ChatBot/chatJsonModel.dart';
import '../../models/ChatBot/chatInitModel.dart';
import '../../services/ChatService.dart';

class ChatUIViewModel extends ChangeNotifier {
  late ChatInitModel? chats;
  bool error = false;
  late List<ChatMessage> messages = [];

  Future<ChatInitModel?> initSession() async {
    try {
      ChatInitModel _list = await WebServiceChatApi().faqInit();
      this.chats = _list;
    } catch (e) {
      error = true;
    }
    notifyListeners();
    return chats;
  }

  addUserMessage(String message, String sessionId) async {
    var box = await Hive.openBox<HiveMessages>('Messages');
    ChatMessage chatMessage = ChatMessage(
        agent: "user",
        message: message
    );
    messages.add(chatMessage);
    HiveMessages hiveMessages = HiveMessages(message: messages.toString());
    box.put(sessionId, hiveMessages);
    notifyListeners();
  }

  sendMessage(String message, String sessionId) async {
    var box = await Hive.openBox<HiveMessages>('Messages');
    try {
      List<ChatJsonModel> _list =
          await WebServiceChatApi().fetchMessageResponse(message, sessionId);
      for (int i = 0; i < _list.length; i++) {
        ChatMessage chatMessage = ChatMessage(
            agent: _list[i].agent,
            message: _list[i].payload.text);
        messages.add(chatMessage);
      }
    } catch (e) {
      error = true;
    }
    HiveMessages hiveMessages = HiveMessages(message: messages.toString());
    box.put(sessionId, hiveMessages);
    notifyListeners();
  }
}
