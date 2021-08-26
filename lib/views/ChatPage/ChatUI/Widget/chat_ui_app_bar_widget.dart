import 'package:flutter/material.dart';

import '../../../../config.dart';

class ChatUIAppBarWidget extends StatelessWidget {
  const ChatUIAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppConfig().primaryColor,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              child: Icon(Icons.person),
            ),
          ),
          Text(
            AppConfig().chatUIHeading,
          ),
        ],
      ),
    );
  }
}
