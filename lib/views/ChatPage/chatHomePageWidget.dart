import 'package:flutter/material.dart';
import '../ChatPage/ChatUI/ChatUIPageWidget.dart';
import '../../views/Widgets/HeadTextWidget.dart';
import '../../config.dart';

class ChatHomePageWidget extends StatelessWidget {
  const ChatHomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadTextWidget(headText: 'Faq\'s'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        elevation: 0.0,
        child: new Icon(Icons.chat),
        backgroundColor: AppConfig().primaryColor,
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ChatUIPageWidget())
        )
      ),
    );
  }
}
