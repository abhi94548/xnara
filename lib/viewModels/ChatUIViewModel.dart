import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/ChatBot/HiveMessageModel.dart';
import '../models/ChatBot/chatJsonModel.dart';

import '../models/ChatBot/chatInitModel.dart';
import '../services/ChatService.dart';

class ChatUIViewModel extends ChangeNotifier {
  late ChatInitModel? chats;
  bool error = false;
  late List<HiveMessages> messages = [];

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
    HiveMessages hiveMessages = HiveMessages(agent: "user", message: message);
    box.add(hiveMessages);
    messages.add(hiveMessages);
    notifyListeners();
  }

  sendMessage(String message, String sessionId) async {
    var box = await Hive.openBox<HiveMessages>('Messages');
    try {
      List<ChatJsonModel> _list =
          await WebServiceChatApi().fetchMessageResponse(message, sessionId);
      for (int i = 0; i < _list.length; i++) {
        HiveMessages hiveMessages =
            HiveMessages(agent: _list[i].agent, message: _list[i].payload.text);
        box.add(hiveMessages);
        messages.add(hiveMessages);
      }
    } catch (e) {
      error = true;
    }
    notifyListeners();
  }
}
