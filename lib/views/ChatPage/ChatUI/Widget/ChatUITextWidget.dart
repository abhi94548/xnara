import 'package:flutter/material.dart';

import '../../../../config.dart';

class ChatUITextWidget extends StatelessWidget {

  const ChatUITextWidget({required this.displayText});
  
  final String displayText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          displayText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: AppConfig().primaryColor,
          ),
        ),
      ),
    );
  }
}
