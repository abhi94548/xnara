import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/ChatBot/HiveMessageModel.dart';

class ChatHomeViewModel extends ChangeNotifier {
  late List<dynamic> sessions;

  Future<List<dynamic>> getAllSessions() async {
    final Box<HiveMessages> box = await Hive.openBox<HiveMessages>('Messages');
    sessions = box.keys.toList();
    notifyListeners();
    return sessions;
  }
}
