import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../views/Widgets/LoadingTextWidget.dart';
import 'ChatUI/Widget/ChatHomeListWidget.dart';
import '../../viewModels/ChatUI/ChatHomeViewModel.dart';
import '../../views/Widgets/HeadTextWidget.dart';

class ChatHomePageWidget extends StatelessWidget {
  const ChatHomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sessionList =
        Provider.of<ChatHomeViewModel>(context, listen: false).getAllSessions();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadTextWidget(headText: 'Faq\'s',routeName : 'chatPage'),
              Flexible(
                child: FutureBuilder(
                  future: sessionList,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null) {
                        print("1");
                        return LoadingTextWidget(
                            loadingText: "No Messages Found");
                      } else {
                        print("3 called");
                        return ChatHomeListWidget(sessions: snapshot.data);
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.active || snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingTextWidget(
                          loadingText: "Loading Please Wait..");
                    } else {
                      print("2");
                      return ChatHomeListWidget(sessions: snapshot.data);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
