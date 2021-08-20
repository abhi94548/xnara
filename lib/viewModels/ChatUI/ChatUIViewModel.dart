import 'package:flutter/material.dart';
import 'package:xnara/models/ChatBot/chatJsonModel.dart';

import '../../models/ChatBot/chatInitModel.dart';
import '../../services/ChatService.dart';


class ChatUIViewModel extends ChangeNotifier{

  late ChatInitModel? chats;
  bool error = false;
  late ChatJsonModel messages;

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

  Future<ChatJsonModel> sendMessage(String message, String sessionId) async {

    try {
      var _list = await WebServiceChatApi().fetchMessageResponse(message, sessionId);
      print(_list);
    }
    catch (e){
      error = true;
    }
    notifyListeners();
    return messages;
  }
}
