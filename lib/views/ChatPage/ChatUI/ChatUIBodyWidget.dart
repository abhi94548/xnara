import 'package:flutter/material.dart';
import 'package:xnara/models/ChatBot/HiveMessageModel.dart';
import '../../../config.dart';

class ChatUIBodyWidget extends StatefulWidget {
  const ChatUIBodyWidget(this.messages, this.scrollController);

  final List<HiveMessages> messages;
  final ScrollController scrollController;

  @override
  _ChatUIBodyWidgetState createState() => _ChatUIBodyWidgetState();
}

class _ChatUIBodyWidgetState extends State<ChatUIBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          controller: widget.scrollController,
          itemCount: widget.messages.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: widget.messages[index].agent == "bot"
                  ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
                  : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: widget.messages[index].agent.toString() == "bot"
                    ? AppConfig().botColor
                    : AppConfig().userColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                widget.messages[index].message,
              ),
            );
          },
        ),
      ),
    );
  }
}
