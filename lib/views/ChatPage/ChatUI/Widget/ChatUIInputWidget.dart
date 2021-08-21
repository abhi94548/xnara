import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../viewModels/ChatUI/ChatUIViewModel.dart';
import '../../../../config.dart';

class ChatUIFormWidget extends StatefulWidget {
  ChatUIFormWidget(
      {required this.context,
      required this.model,
      required this.scrollFunction});

  final BuildContext context;
  final ChatUIViewModel model;
  final Function scrollFunction;

  @override
  _ChatUIFormWidgetState createState() => _ChatUIFormWidgetState();
}

class _ChatUIFormWidgetState extends State<ChatUIFormWidget> {
  final _messageBoxKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(width: 1.0, color: AppConfig().secondaryColor),
      )),
      child: Form(
        key: _messageBoxKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  showCursor: false,
                  controller: myController,
                  enableSuggestions: true,
                  onChanged: (value) => myController.text = value,
                  onTap: () => widget.scrollFunction(),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: "Enter here",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: AppConfig().secondaryColor, width: 1.0),
                    ),
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: AppConfig().secondaryColor, width: 1.0),
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
                    widget.context.read<ChatUIViewModel>().addUserMessage(
                        myController.text,
                        widget.model.chats!.sessionId.toString());
                    widget.context.read<ChatUIViewModel>().sendMessage(
                        myController.text,
                        widget.model.chats!.sessionId.toString());
                    myController.clear();
                    widget.scrollFunction();
                  }
                },
                elevation: 1.0,
                child: new Icon(Icons.send),
                backgroundColor: AppConfig().primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
