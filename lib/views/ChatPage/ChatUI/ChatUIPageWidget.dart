import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../views/ChatPage/ChatUI/ChatUIBodyWidget.dart';
import '../../../views/ChatPage/ChatUI/Widget/ChatUITextWidget.dart';
import '../../../config.dart';
import '../ChatUI/Widget/ChatUIInputWidget.dart';
import '../../../viewModels/ChatUI/ChatUIViewModel.dart';

class ChatUIPageWidget extends StatefulWidget {
  const ChatUIPageWidget({Key? key}) : super(key: key);

  @override
  _ChatUIPageWidgetState createState() => _ChatUIPageWidgetState();
}

class _ChatUIPageWidgetState extends State<ChatUIPageWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  scrollFunction() {
    Timer(
        Duration(milliseconds: 300),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatUIViewModel(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: PreferredSize(
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
          body: SafeArea(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Consumer<ChatUIViewModel>(
                      builder: (context, model, _) {
                        context.read<ChatUIViewModel>().initSession();
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              model.messages.isEmpty
                                  ? ChatUITextWidget(
                                      displayText:
                                          "No Messages yet. Start asking..")
                                  : ChatUIBodyWidget(
                                      model.messages, _scrollController,scrollFunction),
                              context.read<ChatUIViewModel>().error
                                  ? ChatUITextWidget(
                                      displayText:
                                          'Something went wrong. Please try again later..')
                                  : ChatUIFormWidget(
                                      context: context,
                                      model: model,
                                      scrollFunction: scrollFunction),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
