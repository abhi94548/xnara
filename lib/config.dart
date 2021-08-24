import 'dart:ui';

import 'package:flutter/material.dart';

class AppConfig {
  Color get primaryColor => Color(0xFF0097A7);
  Color get secondaryColor => Colors.black12;
  Color get iconColor => Color(0xFF222222);
  Color get botColor => Color(0xFFe3f2fd);
  Color get userColor => Color(0xFF80deea);
  String home = "Home";
  String myUploads = "My Uploads";
  String faq = "Faq";
  String setting = "Settings";
  String foodApiList = "http://164.52.211.147/list";
  String foodApiInference = "http://164.52.211.147/inference";
  String foodApiAdd = "http://164.52.211.147/add";
  String faqInit = "http://164.52.211.147/bot/init";
  String faqChat = "http://164.52.211.147/bot/chat";
  String chatUIHeading = "Ask me Anything";
  String chatUIAgentImage = "https://via.placeholder.com/140x100";
}
