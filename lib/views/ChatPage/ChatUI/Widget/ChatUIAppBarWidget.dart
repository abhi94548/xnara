import 'package:flutter/material.dart';

import '../../../../config.dart';

class ChatUIAppBarWidget extends StatelessWidget {
  const ChatUIAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PreferredSize(
        child: AppBar(
          backgroundColor: AppConfig().primaryColor,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/140x100')),
              ),
              Text(
                AppConfig().chatUIHeading,
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(50),
      ),
    );
  }
}
