import 'package:flutter/material.dart';
import '../../config.dart';

class ChatHomePageWidget extends StatelessWidget {
  const ChatHomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: Text('FAQ\'s'),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        elevation: 0.0,
        child: new Icon(Icons.chat),
        backgroundColor: AppConfig().primaryColor,
        onPressed: (){},
      ),
    );
  }
}
