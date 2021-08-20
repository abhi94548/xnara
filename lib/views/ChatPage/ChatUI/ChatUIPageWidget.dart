import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnara/views/ChatPage/ChatUI/ChatUIBodyWidget.dart';
import '../ChatUI/Widget/ChatUIInputWidget.dart';
import '../../../viewModels/ChatUI/ChatUIViewModel.dart';
import '../../../config.dart';

class ChatUIPageWidget extends StatefulWidget {
  const ChatUIPageWidget({Key? key}) : super(key: key);

  @override
  _ChatUIPageWidgetState createState() => _ChatUIPageWidgetState();
}

class _ChatUIPageWidgetState extends State<ChatUIPageWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatUIViewModel(),
      child: Scaffold(body: Consumer<ChatUIViewModel>(
        builder: (context, model, _) {
          context.read<ChatUIViewModel>().initSession();
          return SafeArea(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PreferredSize(
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
                  context.read<ChatUIViewModel>().error
                      ? Expanded(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                    'Something went wrong. Please try again later',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: AppConfig().iconColor,
                                    )),
                              ),
                            ),
                          ),
                        )
                      : ChatUIFormWidget(context: context, model: model),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
