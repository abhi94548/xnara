import 'package:flutter/material.dart';
import 'package:xnara/models/ChatBot/chatJsonModel.dart';

import '../models/ChatBot/chatInitModel.dart';
import '../services/ChatService.dart';


class ChatUIViewModel extends ChangeNotifier{

  late ChatInitModel? chats;
  bool error = false;
  late List<ChatJsonModel>  messages = [];

  Future<ChatInitModel?> initSession() async {
    try {
      ChatInitModel _list = await WebServiceChatApi().faqInit();
      this.chats = _list;
    }
    catch (e){
      error = true;
    }
    notifyListeners();
    return chats;
  }

  Future<List<ChatJsonModel>> sendMessage(String message, String sessionId) async {
    try {
      List<ChatJsonModel> _list = await WebServiceChatApi().fetchMessageResponse(message, sessionId);
      this.messages = _list;
    }
    catch (e){
      error = true;
    }
    notifyListeners();
    return messages;
  }
}
