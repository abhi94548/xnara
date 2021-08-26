import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../helper/error_handler.dart';
import '../../models/ChatBot/chat_init_model.dart';
import '../../models/ChatBot/chat_json_model.dart';
import '../../models/ChatBot/hive_message_model.dart';
import '../../models/ChatBot/message_model.dart';
import '../../services/chat_service.dart';

enum ChatNotifierState { loading, loaded, error }

class ChatUIViewModel extends ChangeNotifier {
  final WebServiceChatApi webServiceChatApi = WebServiceChatApi();
  late List<ChatMessage> messages = <ChatMessage>[];
  late Box<HiveMessages> box;

  ChatNotifierState _state = ChatNotifierState.loading;

  ChatNotifierState get state => _state;

  void _setState(ChatNotifierState state) {
    _state = state;
    notifyListeners();
  }

  late ChatInitModel _chatInitModel;

  ChatInitModel get chatInitModel => _chatInitModel;

  void _setChatInitModel(ChatInitModel chatInitModel) {
    _chatInitModel = chatInitModel;
    notifyListeners();
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  initSession() async {
    try {
      _setChatInitModel(await webServiceChatApi.faqInit());
      _setState(ChatNotifierState.loaded);
    } on ShowError catch (error) {
      _setState(ChatNotifierState.error);
      _setError(error);
    }
  }

  addUserMessage(String message) async {
    box = await Hive.openBox<HiveMessages>('Messages');
    final ChatMessage chatMessage =
        ChatMessage(agent: 'user', message: message);
    messages.add(chatMessage);
    final HiveMessages hiveMessages =
        HiveMessages(message: messages.toString());
    box.put(chatInitModel.sessionId, hiveMessages);
    notifyListeners();
  }

  sendMessage(String message) async {
    try {
      final List<ChatJsonModel> _list = await webServiceChatApi
          .fetchMessageResponse(message, chatInitModel.sessionId);
      for (int i = 0; i < _list.length; i++) {
        final ChatMessage chatMessage =
            ChatMessage(agent: _list[i].agent, message: _list[i].payload.text);
        messages.add(chatMessage);
      }
      final HiveMessages hiveMessages =
          HiveMessages(message: messages.toString());
      box.put(chatInitModel.sessionId, hiveMessages);
      notifyListeners();
    } on ShowError catch (error) {
      _setState(ChatNotifierState.error);
      _setError(error);
    }
  }
}
