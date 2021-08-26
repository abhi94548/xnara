import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:xnara/helper/error_handler.dart';

import '../../models/ChatBot/hive_message_model.dart';

enum ChatHomeNotifierState { loading, loaded, error }

class ChatHomeViewModel extends ChangeNotifier {

  ChatHomeNotifierState _state = ChatHomeNotifierState.loading;

  ChatHomeNotifierState get state => _state;

  void _setState(ChatHomeNotifierState state) {
    _state = state;
    notifyListeners();
  }

  late List<dynamic> _sessionHistory;

  List<dynamic> get sessionHistory => _sessionHistory;

  void _setSessionHistory(List<dynamic> sessionHistory) {
    _sessionHistory = sessionHistory;
    notifyListeners();
  }


  getAllSessions() async {
    try {
      final Box<HiveMessages> box =
          await Hive.openBox<HiveMessages>('Messages');
      _setSessionHistory(box.keys.toList());
      _setState(ChatHomeNotifierState.loaded);
      notifyListeners();
    } catch (e) {
      _setState(ChatHomeNotifierState.error);
      throw ShowError('Something went wrong');
    }
  }
}
