import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:xnara/models/ChatBot/HiveMessageModel.dart';
import '../../models/ChatBot/MessageModel.dart';


class ChatHomeViewModel extends ChangeNotifier {
  bool error = false;
  late List<ChatMessage> messages = [];
  late List<dynamic> sessions =[];

  getAllSessions() async {
    var box = await Hive.openBox<HiveMessages>('Messages');
    sessions = box.keys.toList();
    notifyListeners();
  }
}
