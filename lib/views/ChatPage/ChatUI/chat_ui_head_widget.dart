import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnara/views/ChatPage/ChatUI/Widget/chat_ui_form_widget.dart';

import '../../../viewModels/ChatUI/chat_ui_view_model.dart';
import '../../../views/ChatPage/ChatUI/Widget/chat_ui_app_bar_widget.dart';
import '../../../views/Widgets/loading_text_widget.dart';
import 'Widget/chat_ui_text_widget.dart';
import 'chat_ui_body_widget.dart';

class ChatUIPageWidget extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  scrollFunction() {
    if (_scrollController.hasClients) {
      Timer(
          const Duration(milliseconds: 300),
          () => _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent));
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ChatUIViewModel>(context, listen: false).initSession();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: ChatUIAppBarWidget(),
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Consumer<ChatUIViewModel>(
              builder: (BuildContext context, ChatUIViewModel model, _) {
                scrollFunction();
                if (model.state == ChatNotifierState.loading) {
                  return const LoadingTextWidget(
                      loadingText: 'Loading Please Wait...');
                } else if (model.state == ChatNotifierState.error) {
                  return Expanded(
                      child: LoadingTextWidget(
                          loadingText: model.error.toString()));
                } else {
                  if (model.messages.isEmpty) {
                    return const ChatUITextWidget(
                        displayText: 'No Messages yet. Start asking..');
                  } else {
                    return ChatUIBodyWidget(
                        model.messages, _scrollController, scrollFunction);
                  }
                }
              },
            ),
            ChatUIFormWidget(context: context, scrollFunction: scrollFunction)
          ],
        )),
      ),
    );
  }
}
