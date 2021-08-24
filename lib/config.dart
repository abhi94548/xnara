import 'dart:ui';

import 'package:flutter/material.dart';

class AppConfig {
  Color get primaryColor => Color(0xFF0097A7);
  Color get secondaryColor => Colors.black12;
  Color get iconColor => Color(0xFF222222);
  Color get botColor => Color(0xFFe3f2fd);
  Color get userColor => Color(0xFF80deea);
  final String home = "Home";
  final String myUploads = "My Uploads";
  final String faq = "Faq";
  final String setting = "Settings";
  final String foodApiList = "http://164.52.211.147/list";
  final String foodApiInference = "http://164.52.211.147/inference";
  final String foodApiAdd = "http://164.52.211.147/add";
  final String faqInit = "http://164.52.211.147/bot/init";
  final String faqChat = "http://164.52.211.147/bot/chat";
  final String chatUIHeading = "Ask me Anything";
  final String chatUIAgentImage = "https://via.placeholder.com/140x100";
}
