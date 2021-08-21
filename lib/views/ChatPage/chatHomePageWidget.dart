import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ChatUI/Widget/ChatHomeListWidget.dart';
import '../../viewModels/ChatUI/ChatHomeViewModel.dart';
import '../ChatPage/ChatUI/ChatUIPageWidget.dart';
import '../../views/Widgets/HeadTextWidget.dart';
import '../../config.dart';

class ChatHomePageWidget extends StatelessWidget {
  const ChatHomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatHomeViewModel(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadTextWidget(headText: 'Faq\'s'),
                Flexible(
                  child: Consumer<ChatHomeViewModel>(
                    builder: (context, model, _) {
                      context.read<ChatHomeViewModel>().getAllSessions();
                      return Container(
                        child: model.sessions.isEmpty
                            ? Center(
                                child: Text(
                                  'No Messages Found.',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: AppConfig().iconColor,
                                  ),
                                ),
                              )
                            : ChatHomeListWidget(sessions: model.sessions),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.chat),
            backgroundColor: AppConfig().primaryColor,
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ChatUIPageWidget()))),
      ),
    );
  }
}
