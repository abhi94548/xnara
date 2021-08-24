import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnara/models/ChatBot/chat_init_model.dart';
import 'package:xnara/views/ChatPage/ChatUI/Widget/chat_ui_app_bar_widget.dart';
import 'package:xnara/views/Widgets/loading_text_widget.dart';

import '../../../viewModels/ChatUI/chat_ui_view_model.dart';
import 'chat_ui_body_widget.dart';
import 'Widget/chat_ui_text_widget.dart';
import 'Widget/chat_ui_form_widget.dart';


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
    final Future<ChatInitModel?> sessionId =
        Provider.of<ChatUIViewModel>(context, listen: false).initSession();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: ChatUIAppBarWidget(),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: sessionId,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  return const LoadingTextWidget(
                      loadingText:
                          'Something went wrong. Please try again later..');
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<ChatUIViewModel>(
                        builder: (BuildContext context, ChatUIViewModel model, _) {
                          return model.messages.isEmpty
                              ? ChatUITextWidget(
                                  displayText:
                                      'No Messages yet. Start asking..')
                              : ChatUIBodyWidget(model.messages,
                                  _scrollController, scrollFunction);
                        },
                      ),
                      ChatUIFormWidget(
                          context: context,
                          model: snapshot.data as ChatInitModel,
                          scrollFunction: scrollFunction),
                    ],
                  );
                }
              } else if (snapshot.connectionState ==
                      ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.active) {
                return const LoadingTextWidget(
                    loadingText: 'Loading Please Wait...');
              } else {
                return const LoadingTextWidget(
                    loadingText: 'Loading Please Wait...');
              }
            },
          ),
        ),
      ),
    );
  }
}