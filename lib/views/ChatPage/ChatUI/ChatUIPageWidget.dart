import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnara/views/ChatPage/ChatUI/Widget/ChatUIAppBarWidget.dart';
import 'package:xnara/views/Widgets/LoadingTextWidget.dart';
import '../../../views/ChatPage/ChatUI/ChatUIBodyWidget.dart';
import '../../../views/ChatPage/ChatUI/Widget/ChatUITextWidget.dart';
import '../../../config.dart';
import '../ChatUI/Widget/ChatUIFormWidget.dart';
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
    var sessionId = Provider.of<ChatUIViewModel>(context,listen: false).initSession();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          child: ChatUIAppBarWidget(),
          preferredSize: Size.fromHeight(50),
        ),
        body: SafeArea(
          child: Container(
            child: Flexible(
              child: FutureBuilder(
                future: sessionId,
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.data == null){
                      return LoadingTextWidget(loadingText: "Something went wrong. Please try again later..");
                    }
                    else{
                       return Consumer<ChatUIViewModel>(
                           builder: (context,model,_){
                             return Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 model.messages.isEmpty
                                     ? ChatUITextWidget(
                                     displayText:
                                     "No Messages yet. Start asking..")
                                     : ChatUIBodyWidget(
                                     model.messages, _scrollController,scrollFunction),
                                 ChatUIFormWidget(
                                     context: context,
                                     model: snapshot.data,
                                     scrollFunction: scrollFunction),
                               ],
                             );
                           },
                       );
                    }
                  }
                  else if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active){
                    return LoadingTextWidget(loadingText: "Loading Please Wait...");
                  }
                  else{
                    return LoadingTextWidget(loadingText: "Loading Please Wait...");
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
