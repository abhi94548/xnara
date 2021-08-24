import 'package:flutter/material.dart';
import 'package:xnara/models/ChatBot/message_model.dart';
import '../../../config.dart';

class ChatUIBodyWidget extends StatelessWidget {
  const ChatUIBodyWidget(
      this.messages, this.scrollController, this.scrollFunction);

  final List<ChatMessage> messages;
  final ScrollController scrollController;
  final Function scrollFunction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
        child: ListView.builder(
          itemCount: messages.length,
          shrinkWrap: true,
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: messages[index].agent == 'bot'
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      color: messages[index].agent.toString() == 'bot'
                          ? AppConfig().botColor
                          : AppConfig().userColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      messages[index].message,
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
