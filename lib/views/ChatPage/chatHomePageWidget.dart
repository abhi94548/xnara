import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModels/ChatUI/ChatHomeViewModel.dart';
import '../../views/Widgets/HeadTextWidget.dart';
import '../../views/Widgets/LoadingTextWidget.dart';
import 'ChatUI/Widget/ChatHomeListWidget.dart';

class ChatHomePageWidget extends StatelessWidget {
  const ChatHomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<List<dynamic>> sessionList =
        Provider.of<ChatHomeViewModel>(context, listen: false).getAllSessions();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const HeadTextWidget(headText: 'Chat Faq',routeName : 'chatPage'),
            Flexible(
              child: FutureBuilder<List<dynamic>>(
                future: sessionList,
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null) {
                      return const LoadingTextWidget(
                          loadingText: 'No Messages Found');
                    } else {
                      return ChatHomeListWidget(sessions: snapshot.data as List<dynamic>);
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.active || snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingTextWidget(
                        loadingText: 'Loading Please Wait..');
                  } else {
                    return ChatHomeListWidget(sessions: snapshot.data as List<dynamic>);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
