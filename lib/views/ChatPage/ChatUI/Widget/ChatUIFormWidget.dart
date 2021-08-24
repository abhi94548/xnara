import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnara/models/ChatBot/chat_Init_Model.dart';

import '../../../../config.dart';
import '../../../../viewModels/ChatUI/ChatUIViewModel.dart';

class ChatUIFormWidget extends StatelessWidget {
  ChatUIFormWidget(
      {required this.context,
      required this.model,
      required this.scrollFunction});

  final BuildContext context;
  final ChatInitModel model;
  final Function scrollFunction;

  final GlobalKey<FormState> _messageBoxKey = GlobalKey<FormState>();
  final TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(color: AppConfig().secondaryColor),
      )),
      child: Form(
        key: _messageBoxKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: myController,
                  onTap: () => scrollFunction(),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Enter here',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: AppConfig().secondaryColor, width: 1.0),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: AppConfig().secondaryColor),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                mini: true,
                onPressed: () {
                  if (myController.text.isNotEmpty) {
                    context.read<ChatUIViewModel>().addUserMessage(
                        myController.text, model.sessionId.toString());
                    context.read<ChatUIViewModel>().sendMessage(
                        myController.text, model.sessionId.toString());
                    myController.clear();
                    scrollFunction();
                  }
                },
                elevation: 1.0,
                backgroundColor: AppConfig().primaryColor,
                child: const Icon(Icons.send),
              ),
            )
          ],
        ),
      ),
    );
  }
}
