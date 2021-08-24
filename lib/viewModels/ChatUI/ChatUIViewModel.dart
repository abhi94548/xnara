
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:xnara/models/ChatBot/HiveMessageModel.dart';

import '../../models/ChatBot/MessageModel.dart';
import '../../models/ChatBot/chat_Init_Model.dart';
import '../../models/ChatBot/chat_Json_Model.dart';
import '../../services/ChatService.dart';

class ChatUIViewModel extends ChangeNotifier {
  late ChatInitModel? chats;
  late List<ChatMessage> messages = [];

  Future<ChatInitModel?> initSession() async {
    try {
      final ChatInitModel _list = await WebServiceChatApi().faqInit();
      if (_list.success) {
        chats = _list;
        notifyListeners();
        return chats;
      } else {
        notifyListeners();
        return null;
      }
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }

  addUserMessage(String message, String sessionId) async {
    final Box<HiveMessages> box = await Hive.openBox<HiveMessages>('Messages');
    final ChatMessage chatMessage = ChatMessage(agent: 'user', message: message);
    messages.add(chatMessage);
    final HiveMessages hiveMessages = HiveMessages(message: messages.toString());
    box.put(sessionId, hiveMessages);
    notifyListeners();
  }

  sendMessage(String message, String sessionId) async {
    final Box<HiveMessages> box = await Hive.openBox<HiveMessages>('Messages');
    try {
      final List<ChatJsonModel> _list =
          await WebServiceChatApi().fetchMessageResponse(message, sessionId);
      for (int i = 0; i < _list.length; i++) {
        final ChatMessage chatMessage =
            ChatMessage(agent: _list[i].agent, message: _list[i].payload.text);
        messages.add(chatMessage);
      }
    } catch (e) {
      throw Exception('Something went wrong');
    }
    final HiveMessages hiveMessages = HiveMessages(message: messages.toString());
    box.put(sessionId, hiveMessages);
    notifyListeners();
  }
}
