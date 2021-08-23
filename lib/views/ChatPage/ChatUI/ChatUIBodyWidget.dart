import 'package:flutter/material.dart';
import 'package:xnara/models/ChatBot/MessageModel.dart';
import '../../../config.dart';

class ChatUIBodyWidget extends StatefulWidget {
  const ChatUIBodyWidget(this.messages, this.scrollController,this.scrollFunction);

  final List<ChatMessage> messages;
  final ScrollController scrollController;
  final Function scrollFunction;

  @override
  _ChatUIBodyWidgetState createState() => _ChatUIBodyWidgetState();
}

class _ChatUIBodyWidgetState extends State<ChatUIBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0,top: 5.0,bottom: 5.0),
        child: ListView.builder(
          itemCount: widget.messages.length,
          shrinkWrap: true,
          controller: widget.scrollController,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: widget.messages[index].agent == "bot"
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      color: widget.messages[index].agent.toString() == "bot"
                          ? AppConfig().botColor
                          : AppConfig().userColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.messages[index].message,
                      softWrap: true,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
