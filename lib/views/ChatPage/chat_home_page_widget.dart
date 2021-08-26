import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModels/ChatUI/chat_home_view_model.dart';
import '../Widgets/head_text_widget.dart';
import '../Widgets/loading_text_widget.dart';
import 'ChatUI/Widget/chat_home_list_widget.dart';

class ChatHomePageWidget extends StatelessWidget {
  const ChatHomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ChatHomeViewModel>(context, listen: true).getAllSessions();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const HeadTextWidget(headText: 'Chat Faq', routeName: 'chatPage'),
            Flexible(
              child: Consumer<ChatHomeViewModel>(
                builder: (BuildContext context, ChatHomeViewModel model, _) {
                  if (model.state == ChatHomeNotifierState.loading) {
                    return const LoadingTextWidget(
                        loadingText: 'Loading Please Wait...');
                  } else if (model.state == ChatHomeNotifierState.error) {
                    return const LoadingTextWidget(loadingText: 'Something went wrong');
                  } else {
                    if (model.sessionHistory.isEmpty) {
                      return const LoadingTextWidget(loadingText: 'No History Found');
                    } else {
                      return ChatHomeListWidget(sessions: model.sessionHistory);
                    }
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
