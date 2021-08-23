import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/ChatBot/HiveMessageModel.dart';

class ChatHomeViewModel extends ChangeNotifier {
  late List<dynamic> sessions;

  Future<List<dynamic>?> getAllSessions() async {
    var box = await Hive.openBox<HiveMessages>('Messages');
    print("code runned");
    sessions = box.keys.toList();
    if (sessions.isEmpty) {
      notifyListeners();
      return null;
    } else {
      notifyListeners();
      return sessions;
    }
  }
}
