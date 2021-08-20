import 'package:flutter/material.dart';
import 'package:xnara/config.dart';
import 'package:xnara/models/ChatBot/chatMessageModel.dart';

class ChatUIBodyWidget extends StatefulWidget {
  ChatUIBodyWidget({required this.messageModel});

  final ChatMessageModel messageModel;

  @override
  _ChatUIBodyWidgetState createState() => _ChatUIBodyWidgetState();
}

class _ChatUIBodyWidgetState extends State<ChatUIBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.messageModel.messages.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: widget.messageModel.messages[index].agent == "bot"
                    ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
                    : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                decoration: BoxDecoration(
                    color: widget.messageModel.messages[index].agent == "bot"
                        ? AppConfig().botColor
                        : AppConfig().userColor,
                    borderRadius: widget.messageModel.messages[index].agent ==
                        "bot" ?
                    BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                    ) :
                    BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                    )
                ),
                child: Text(
                  widget.messageModel.messages[index].payload.text.toString(),

                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
